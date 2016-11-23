require './Models/base_object.rb'

class Book < BaseObject
    attr_accessor :title, :author
    def initialize(title, author)
        super()
        @title, @author = title, author
    end
    def to_s
        @guid.to_s + ' ' + @title
    end
end
