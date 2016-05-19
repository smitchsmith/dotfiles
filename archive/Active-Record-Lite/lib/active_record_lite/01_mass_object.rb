require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject
  def self.my_attr_accessible(*new_attributes)
    attributes.concat(new_attributes)
  end

  def self.attributes
    raise "must not call #attributes on MassObject directly" if self == MassObject
    @attributes ||= []
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if (self.class::attributes).include?(attr_name.to_sym)
        self.send("#{attr_name}=", value)
      else
        raise "mass assignment to unregistered attribute '#{attr_name}'"
      end
    end
  end

end