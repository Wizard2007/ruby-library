require './Models/base_object.rb'

class Book < Base_object
    attr_accessor :title, :author
    def initialize(title, author)
        super()
        @title, @author = title, author
    end
end
