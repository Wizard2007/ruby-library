require './Models/library.rb'

library = Library.new
library._load_all_data

puts 'most popular book is '
puts library.get_most_popular_book.to_s
puts '------------------------------------------------'
puts 'most often take book reader is'
puts library.get_often_take_book_reader
puts '------------------------------------------------'
puts 'count 3 most popular book readers ' + library.count_3_mpb_readers.to_s
puts '------------------------------------------------'
