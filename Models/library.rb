require './Models/author.rb'
require './Models/book.rb'
require './Models/order.rb'
require './Models/reader.rb'

class Library
  attr_accessor :books, :authors, :orders, :readers

  def initialize
    @books, @authors, @orders, @readers = [], [], [], []
  end

  def get_class_name(source)
    source_str = String.new(source)
    source_str.sub!('@','').chr.capitalize + source_str.slice(1,source_str.length - 1).chop!
  end

  def add_object(collection_name = '', options = {})
    klass_name = get_class_name(collection_name)
    obj = Kernel.const_get(klass_name).add(options)
    instance_variable_get("#{collection_name}") << obj
    obj
  end

  def save_to_file(path_to_file, collection)
    file = File.new(path_to_file, 'w+')
    collection.each{|obj| file.puts obj.get_as_delimiter_str}
  end

  def get_file_name(collection_name)
    "#{collection_name.sub('@', '')}.txt"
  end

  def load_data(collection_name)
    File.open(get_file_name(collection_name), 'r').each do |line|
      obj = add_object(collection_name, {})
      obj.get_instance_vars_from_str(line)
    end
  end

  def load_all_data
    instance_variables.map {|var| load_data(var.to_s) }
  end

  def save_all_data
    instance_variables.map {|var| save_to_file(get_file_name(var.to_s), var)}
  end

  def get_item_by_guid(guid, collection)
    results = collection.select{|element| element.guid == guid}
    results[0] if results.size > 0
  end

  def get_most_popular_book
    l_orders = group_by_and_sort_orders
    get_item_by_guid(l_orders[0][0], books)
  end

  def get_often_take_book_reader
    l_orders = orders.group_by(&:reader).sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
    get_item_by_guid(l_orders[l_orders.size-1][0], readers)
  end

  def count_3_mpb_readers
    l_books = group_by_and_sort_orders(3).map {|elements| elements[0]}
    orders.select{|order| l_books.include?(order.book) }.group_by(&:reader).size
  end

  def group_by_and_sort_orders(count = 1)
    orders.group_by(&:book).sort{ |x, y| x[1, 1][0].size <=>y[1, 1][0].size }.to_a.last(count)
  end
end
