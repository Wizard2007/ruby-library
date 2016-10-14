require 'securerandom'

class Base_object
    attr_accessor :guid
    def initialize
        @guid = SecureRandom.uuid
    end
    def get_as_delimetered_str(delimeter = ';')
        result = ''
        instance_variables.map do |attribute|  
            result += instance_variable_get(attribute).to_s + delimeter 
        end
        return result
    end
    def get_instance_variables_from_str(a_source_str, a_delimeter = ';')
        #puts a_source_str
        values = a_source_str.split(a_delimeter)
        i = 0
        instance_variables.map do |attribute|  
            instance_variable_set(attribute,values[i]) 
            i = i + 1;
            #puts attribute.to_s
            #puts i
            #puts values[i]            
        end        
    end

end