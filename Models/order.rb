require './Models/base_object.rb'
require 'date'

class Order < BaseObject
    attr_accessor :book, :reader, :date
    def initialize(book: '', reader: '', date: nil)
        super({guid: guid})
        (date == nil) ? @date = Date.new : @date = date
        @book, @reader = book, reader
    end
    def to_s
        '@book =' + @book + ' @reader =' + @reader + ' @date =' + @date.to_s + ' @guid ='+ guid
    end
    def self.add(option = {})
        Order.new(option)
    end
end
