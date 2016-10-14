require './Models/base_object.rb'
require 'date'

class Order < Base_object
    attr_accessor :book, :reader, :date
    def initialize(book, reader, date)
        super()
        @date = Date.new
        @book, @reader, @date = book, reader, date
    end
    def to_s
        puts @book + ' ' + @reader + ' ' + @date.to_s + ' '+ guid
    end
end