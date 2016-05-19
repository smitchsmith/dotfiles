require_relative '03_searchable'
require 'active_support/inflector'

# Phase IVa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key,
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  attr_accessor :name, :class_name, :foreign_key, :primary_key

  def initialize(name, options = {})
    name.is_a?(Symbol) ? name = name.to_s : name

    values = {
      :class_name => name.camelcase,
      :foreign_key => "#{name}_id".to_sym,
      :primary_key => :id
    }

    values = values.merge(options)

    @name = name.to_sym
    @class_name = values[:class_name]
    @foreign_key = values[:foreign_key]
    @primary_key = values[:primary_key]
  end
end

class HasManyOptions < AssocOptions
  attr_accessor :name, :class_name, :foreign_key, :primary_key

  def initialize(name, self_class_name, options = {})
    name.is_a?(Symbol) ? name = name.to_s : name

    values = {
      :class_name => name.singularize.camelcase,
      :foreign_key => "#{self_class_name.downcase.singularize}_id".to_sym,
      :primary_key => :id
    }

    values = values.merge(options)

    @name = name.to_sym
    @class_name = values[:class_name]
    @foreign_key = values[:foreign_key]
    @primary_key = values[:primary_key]
  end
end

module Associatable
  # Phase IVb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      fk_value = self.send(options.foreign_key)
      options.model_class
      .where(options.primary_key => fk_value)
      .first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)

    define_method(name) do
      pk_value = self.send(options.primary_key)
      options.model_class
      .where(options.foreign_key => pk_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
