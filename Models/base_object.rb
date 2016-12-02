require 'securerandom'

class BaseObject
  attr_accessor :guid

  def initialize(guid: nil)
    (guid == nil) ? @guid = SecureRandom.uuid : @guid = guid
  end

  def get_as_delimiter_str(delimiter = ';')
    instance_variables.map {|attr| instance_variable_get(attr).to_s}.join(delimiter)
  end

  def get_instance_vars_from_str(source_str, delimiter = ';')
    values = source_str.split(delimiter)
    instance_variables.map.with_index do |attribute, index|
      instance_variable_set(attribute,values[index])
    end
  end
end
