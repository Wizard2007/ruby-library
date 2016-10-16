require './Models/library.rb'
require 'date'

library = Library.new
library._load_all_data
# first test get most popular book
#a = library.orders.group_by{ |o| o.book}
#puts a.size
#a.each do |x|
#    puts x.size
#    puts x.class
#    puts '----'
#    #puts 'x[0] = '+x[0]
#    puts 'x[0, 0] = '+x[1, 1][0].size.to_s
#    puts 'x[0, 0] = '+x[0, 0].to_s
#    puts 'x[0, 1] = '+x[0, 1].to_s
#    puts 'x[1, 0] = '+x[1, 0].to_s
#    puts 'x[1, 1] = '+x[1, 1].to_s
#    puts 'x[2, 0] = '+x[2, 0].to_s
#    puts 'x[2, 1] = '+x[2, 1].to_s

#    x.each_with_index{|item, index| puts 'x['+index.to_s+'] = '+item.to_s }
#    #x.each_index {|x1| print x1, " -- " }
#    x.each do
#        |y| puts y.size
#    end
#    puts '----'

#end

# test get most popular book
#b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
#puts b[b.size-1]
#puts '------'
#puts b[b.size-1][0]
#puts '------'
#puts a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}[a.size-1][0]

# Tmp data generator
#library._generate_tmp_readers(10)
#library._generate_tmp_authors(9)
#library._generate_tmp_books(20)
#library._generate_tmp_orders(60)
#library._save_all_data

# read data test
#puts 'read file'
#library._read_from_file('./ordes.txt') {library.addOrder()}
#puts 'read end'
#puts library.orders.size
#puts '------------------------------'
#puts library.orders.each{ |order|
#    puts '==='
#    puts order.get_as_delimetered_str
#    puts '==='
#    }
#puts '------------------------------'

# test add elemets
#library.AddOrder('1', '2', Date.parse(Time.now.to_s))
#library.AddOrder('3', '4', Date.parse(Time.now.to_s))

# test save elements
#library.SaveToFile('./ordes.txt', library.orders)
puts 'most popular book is '
puts library.get_most_popular_book.to_s
puts '------------------------------------------------'
puts 'most often take book reader is'
puts library.get_often_take_book_reader
puts '------------------------------------------------'
puts 'count 3 most popular book readers ' + library.count_3_mpb_readers.to_s
puts '------------------------------------------------'
