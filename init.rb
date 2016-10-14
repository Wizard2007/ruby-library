require './Models/library.rb'
require 'date'

library = Library.new
library.AddOrder('1', '2', Date.parse(Time.now.to_s))
library.AddOrder('3', '4', Date.parse(Time.now.to_s))