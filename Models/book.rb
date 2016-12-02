require './Models/base_object.rb'

class Book < BaseObject
    attr_accessor :title, :author
    def initialize(guid: nil, title: '', author: '')
        super({guid: guid})
        @title, @author = title, author
    end
    def to_s
        @guid.to_s + ' ' + @title
    end
    def self.add(option = {})
        Book.new(option)
    end
end
