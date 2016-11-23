require './Models/base_object.rb' 

class Author < BaseObject
    attr_accessor :name, :biography
    def initialize(name, biography)
        super()
        @name, @biography = name, biography
    end
end