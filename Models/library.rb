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
    def _add_book(a_name = '', a_biography = '', a_guid = nil)
        book = Book.new(a_name, a_biography)
        book.guid = a_guid if a_guid
        books << book
        book
    end
        def _add_author(name = '', biography = '', a_guid = nil)
        author = Author.new(name, biography)
        author.guid = a_guid if a_guid
        authors << author
        author
    end
    def _add_reader(a_name = '', a_email = '', a_city = '', a_street = '', a_house = '', a_guid = nil)
        reader = Reader.new(a_name, a_email, a_city, a_street, a_house)
        reader.guid = a_guid if a_guid
        readers << reader
        reader
    end
    def _add_order(a_book_guid = '', a_reader_guid = '', a_date = nil, a_guid = nil)
        order = Order.new(a_book_guid, a_reader_guid, a_date)                
        order.guid = a_guid if a_guid              
        orders << order
        order
    end
    def _save_to_file(a_path_to_file, a_collection)
        f = File.new(a_path_to_file, 'w+')
        a_collection.each{|a| f.puts a.get_as_delimetered_str}        
    end    
    def _generate_tmp_data(a_n)
        i = 1
        loop do
            a = yield
            a.generate(i)
            break if i == a_n
            i+1
        end
    end
    def _generate_tmp_readers(a_n)
        _generate_tmp_data(a_n) { _add_reader
        }
    end
    def _generate_tmp_books(a_n)
        _generate_tmp_data(a_n) { _add_book
        }
        _rnd_authoe = Random.new
        books.each {|b| b.author = authors[_rnd_authoe.rand(authors.size)].guid}
    end
    def _generate_tmp_authors(a_n)
        _generate_tmp_data(a_n) { _add_author
        }
    end
    def _generate_tmp_orders(a_n)
        _rnd_reader = Random.new
        _rnd_book = Random.new
        i = 1
        loop do
            _add_order(books[_rnd_book.rand(books.size)].guid,
                       readers[_rnd_reader.rand(readers.size)].guid,
                       Date.parse(Time.now.to_s))
            break if i == a_n
            i+=1
        end
    end
    def _read_from_file(a_path_to_file)
        File.open(a_path_to_file, 'r').each do |line|          
          a = yield 
          a.get_instance_vars_from_str(line)
        end
    end
    def _save_orders(a_path)
        a_path = path_to_orders if a_path == ''
        _save_to_file(a_path, orders)
    end
    def _save_books(a_path)
        a_path = path_to_books if a_path == ''
        _save_to_file(a_path, books)
    end
    def _save_authors(a_path)
        a_path = path_to_authors if a_path == ''
        _save_to_file(a_path, authors)
    end
    def _save_readers(a_path)
        a_path = path_to_readers if a_path == ''
        _save_to_file(a_path, readers)
    end
    def _load_orders(a_path)
        a_path = path_to_orders if a_path == ''
        _read_from_file(a_path) { _add_order
        }
    end
    def _load_books(a_path)
        a_path = path_to_books if a_path == ''
        _read_from_file(a_path) { _add_book
        }
    end
    def _load_authors(a_path)
        a_path = path_to_authors if a_path == ''
        _read_from_file(a_path) { _add_author
        }
    end
    def _load_readers(a_path)
        a_path = path_to_readers if a_path == ''
        _read_from_file(a_path) { _add_reader
        }
    end
    def _load_all_data(a_path_to_books = '', a_path_to_authors = '', a_path_to_readers = '', a_path_to_orders = '')
        _load_orders(a_path_to_orders)
        _load_books(a_path_to_books)
        _load_authors(a_path_to_authors)
        _load_readers(a_path_to_readers)
    end
    def _save_all_data(a_path_to_books = '', a_path_to_authors = '', a_path_to_readers = '', a_path_to_orders = '')
        _save_orders(a_path_to_orders)
        _save_books(a_path_to_books)
        _save_authors(a_path_to_authors)
        _save_readers(a_path_to_readers)
    end
    def get_item_by_guid(a_guid, a_collection)
        result = nil
        a1 = a_collection.select{|a| a.guid == a_guid}
        result = a1[0] if a1.size > 0
        result
    end
    def get_most_popular_book
        a = orders.group_by{ |o| o.book}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        get_item_by_guid(b[a.size-1][0], books)
    end
    def get_often_take_book_reader
        a = orders.group_by{ |o| o.reader}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        get_item_by_guid(b[a.size-1][0], readers)
    end
    def count_3_mpb_readers
        a = orders.group_by{ |o| o.book}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        l_books = []
        l_books << b[a.size-1][0] << b[a.size-2][0] << b[a.size-3][0]
        l_orders = orders.select{|o| l_books.index(o.book) != nil}
        l_orders.group_by{ |o| o.reader}.size
    end
end
