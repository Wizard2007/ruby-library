require 'securerandom'

class BaseObject
    attr_accessor :guid
    def initialize
        @guid = SecureRandom.uuid
    end
    def get_as_delimetered_str(delimeter = ';')
        result = ''
        instance_variables.map do |attribute|  
            result += instance_variable_get(attribute).to_s + delimeter 
        end
        result
    end
    def get_instance_vars_from_str(source_str, delimeter = ';')
        values = source_str.split(delimeter)
        instance_variables.map.with_index do |attribute, index|  
            instance_variable_set(attribute,values[index])            
        end        
    end
    def generate(index)
        instance_variables.map do |attribute|
            instance_variable_set(attribute,attribute.to_s + '_'+index.to_s) if attribute.to_s != '@guid'
        end
    end

end
