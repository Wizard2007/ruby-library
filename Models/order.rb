require './Models/base_object.rb'
require 'date'

class Order < BaseObject
    attr_accessor :book, :reader, :date
    def initialize(book, reader, date)
        super()
        @date = Date.new
        @book, @reader, @date = book, reader, date
    end
    def to_s
        puts '@book =' + @book + ' @reader =' + @reader + ' ' + @date.to_s + ' guid ='+ guid
    end
end
