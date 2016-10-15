require './Models/library.rb'
require 'date'

library = Library.new
library.generateTmpReaders(10)
library.generateTmpAuthors(9)
library.generateTmpBooks(20)
library.generateTmpOrders(60)
library.saveAllData

puts 'read file'
library.readFromFile('./ordes.txt') {library.addOrder()}
puts 'read end'
puts library.orders.size
puts '------------------------------'
puts library.orders.each{ |order| 
    puts '==='
    puts order.get_as_delimetered_str
    puts '==='
    }
puts '------------------------------'
#library.AddOrder('1', '2', Date.parse(Time.now.to_s))
#library.AddOrder('3', '4', Date.parse(Time.now.to_s))

#library.SaveToFile('./ordes.txt', library.orders)
