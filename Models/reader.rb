require './Models/base_object.rb'

class Reader < BaseObject
    attr_accessor :name, :email, :city, :street, :house
    def initialize(guid: nil, name: '', email: '', city: '', street: '', house: '')
        super({guid: guid})
        @name, @email, @city, @street, @house = name, email, city, street, house
    end
    def to_s
        @guid.to_s + ' ' + @name
    end
    def self.add(option = {})
        Reader.new(option)
    end
end
