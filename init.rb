require './Models/library.rb'
require 'date'

library = Library.new
puts 'read file'
library.ReadFromFile('./ordes.txt') {library.AddOrder()}
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