require 'securerandom'

class Base_object
    attr_accessor :guid
    def initialize
        @guid = SecureRandom.uuid
    end
    def get_as_str(delimeter = ';')
        result = ''
        instance_variables.map do |attribute|  
            result += instance_variable_get(attribute.to_s).to_s + delimeter 
        end       
        return result
    end
end