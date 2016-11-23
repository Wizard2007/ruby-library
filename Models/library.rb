require './Models/author.rb'
require './Models/book.rb'
require './Models/order.rb'
require './Models/reader.rb'

class Library
    attr_accessor :books, :authors, :orders, :readers    
    attr_accessor :path_to_books , :path_to_authors, :path_to_readers, :path_to_orders
    def initialize
        @books, @authors, @orders, @readers = [], [], [], []
        @path_to_orders = './ordes.txt'
        @path_to_books = './books.txt'
        @path_to_authors = './authors.txt'
        @path_to_readers = './readers.txt'
    end
    def add_book(name = '', biography = '', guid = nil)
        book = Book.new(name, biography)
        book.guid = guid if guid
        books << book
        book
    end
    def add_author(name = '', biography = '', guid = nil)
        author = Author.new(name, biography)
        author.guid = guid if guid
        authors << author
        author
    end
    def add_reader(name = '', email = '', city = '', street = '', house = '', guid = nil)
        reader = Reader.new(name, email, city, street, house)
        reader.guid = guid if guid
        readers << reader
        reader
    end
    def add_order(book_guid = '', reader_guid = '', date = nil, guid = nil)
        order = Order.new(book_guid, reader_guid, date)
        order.guid = guid if guid
        orders << order
        order
    end
    def save_to_file(path_to_file, collection)
        file = File.new(path_to_file, 'w+')
        collection.each{|a| file.puts a.get_as_delimetered_str}
    end    
    def generate_tmp_data(n)
        n.times do |i|
            a = yield
            a.generate(i)            
        end
    end
    def generate_tmp_readers(n)
        generate_tmp_data(n) {add_reader}
    end
    def generate_tmp_books(n)
        generate_tmp_data(n) {add_book}
        rnd_authoe = Random.new
        books.each {|book| book.author = authors[rnd_authoe.rand(authors.size)].guid}
    end
    def _generate_tmp_authors(n)
        generate_tmp_data(n) {add_author}
    end
    def generate_tmp_orders(n)
        rnd_reader = Random.new
        rnd_book = Random.new
        n.times do |i|
            add_order(books[rnd_book.rand(books.size)].guid,
                      readers[rnd_reader.rand(readers.size)].guid,
                      Date.parse(Time.now.to_s))
        end
    end
    def read_from_file(path_to_file)
        File.open(path_to_file, 'r').each do |line|
          a = yield 
          a.get_instance_vars_from_str(line)
        end
    end
    def save_orders(path)
        path = path_to_orders if path == ''
        save_to_file(path, orders)
    end
    def save_books(path)
        path = path_to_books if path == ''
        save_to_file(path, books)
    end
    def save_authors(path)
        path = path_to_authors if path == ''
        save_to_file(path, authors)
    end
    def save_readers(path)
        path = path_to_readers if path == ''
        save_to_file(path, readers)
    end
    def load_orders(path)
        path = path_to_orders if path == ''
        read_from_file(path) {add_order}
    end
    def load_books(path)
        path = path_to_books if path == ''
        read_from_file(path) {add_book}
    end
    def load_authors(path)
        path = path_to_authors if path == ''
        read_from_file(path) {add_author}
    end
    def load_readers(path)
        path = path_to_readers if path == ''
        read_from_file(path) {add_reader}
    end
    def load_all_data(path_to_books = '', path_to_authors = '', path_to_readers = '', path_to_orders = '')
        load_orders(path_to_orders)
        load_books(path_to_books)
        load_authors(path_to_authors)
        load_readers(path_to_readers)
    end
    def save_all_data(path_to_books = '', path_to_authors = '', path_to_readers = '', path_to_orders = '')
        save_orders(path_to_orders)
        save_books(path_to_books)
        save_authors(path_to_authors)
        save_readers(path_to_readers)
    end
    def get_item_by_guid(guid, collection)
        result = nil
        results = collection.select{|element| element.guid == guid}
        result = results[0] if results.size > 0
        result
    end
    def get_most_popular_book
        a = orders.group_by{ |order| order.book}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        get_item_by_guid(b[a.size-1][0], books)
    end
    def get_often_take_book_reader
        a = orders.group_by{ |order| order.reader}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        get_item_by_guid(b[a.size-1][0], readers)
    end
    def count_3_mpb_readers
        a = orders.group_by{ |order| order.book}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        l_books = []
        l_books << b[a.size-1][0] << b[a.size-2][0] << b[a.size-3][0]
        l_orders = orders.select{|order| l_books.index(order.book) != nil}
        l_orders.group_by{ |order| order.reader}.size
    end
end
