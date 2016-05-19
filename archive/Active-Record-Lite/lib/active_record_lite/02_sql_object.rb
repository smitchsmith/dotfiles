require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'

class MassObject
  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end
  end
end

class SQLObject < MassObject
  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.all
    sql = <<-SQL
    SELECT #{self.table_name}.*
    FROM #{self.table_name}
    SQL

    parse_all(DBConnection.execute(sql))
  end

  def self.find(id)
    sql = <<-SQL
    SELECT #{self.table_name}.*
    FROM #{self.table_name}
    WHERE #{self.table_name}.id = ?
    LIMIT 1
    SQL

    parse_all(DBConnection.execute(sql, id)).first
  end

  def insert
    col_names = self.class.attributes.join(", ")
    question_marks = self.class.attributes.map{"?"}.join(", ")

    sql = <<-SQL
    INSERT INTO #{self.class.table_name} (#{col_names})

    VALUES
      (#{question_marks})
    SQL

    DBConnection.execute(sql, *attribute_values)
    self.id = DBConnection.last_insert_row_id
  end

  def save
    if self.id
      update
    else
      insert
    end
  end

  def update
    set_line = self.class.attributes.map{ |a| "#{a} = ?" }.join(", ")

    sql = <<-SQL
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE #{self.class.table_name}.id = ?
    SQL

    DBConnection.execute(sql, *attribute_values, self.id)
  end

  def attribute_values
    self.class.attributes.map do |attr|
      self.send("#{attr}")
    end
  end
end
