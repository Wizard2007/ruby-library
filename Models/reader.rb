require './Models/base_object.rb'

class Reader < Base_object
    attr_accessor :name, :email, :city, :street, :house
    def initialize(name, email, city, street, house)
        super()
        @name, @email, @city, @street, @house = name, email, city, street, house
    end
end