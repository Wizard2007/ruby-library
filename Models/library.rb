require './Models/author.rb'
require './Models/book.rb'
require './Models/order.rb'
require './Models/reader.rb'

class Library
    attr_accessor :books, :authors, :orders, :readers    
    attr_accessor :path_to_books , :path_to_authors, :path_to_readers, :path_to_orders
    def initialize()
        @books, @authors, @orders, @readers = [], [], [], []
        @path_to_orders = './ordes.txt'
        @path_to_books = './books.txt'
        @path_to_authors = './authors.txt'
        @path_to_readers = './readers.txt'
    end
    def addBook(a_name = '', a_biography = '', a_guid = nil)
        book = Book.new(a_name, a_biography)
        book.guid = a_guid if a_guid
        books << book
        return book
    end
    def addAuthor(name = '', biography = '', a_guid = nil)
        author = Author.new(name, biography)
        author.guid = a_guid if a_guid
        authors << author
        return author
    end
    def addReader(a_name = '', a_email = '', a_city = '', a_street = '', a_house = '', a_guid = nil)
        reader = Reader.new(a_name, a_email, a_city, a_street, a_house)
        reader.guid = a_guid if a_guid
        readers << reader
        return reader
    end
    def addOrder(a_book_guid = '', a_reader_guid = '', a_date = nil, a_guid = nil)
        order = Order.new(a_book_guid, a_reader_guid, a_date)                
        order.guid = a_guid if a_guid              
        orders << order
        return order
    end
    def saveToFile(a_path_to_file, a_collection)
        f = File.new(a_path_to_file, "w+")
        a_collection.each{|a| f.puts a.get_as_delimetered_str}        
    end    
    def generateTmpData(a_n)
        for i in 1..a_n
            a = yield
            a.generate(i)
        end
    end
    def generateTmpReaders(a_n)
        generateTmpData(a_n) {addReader()}
    end
    def generateTmpBooks(a_n)
        generateTmpData(a_n) {addBook()}
        rndAuthoe = Random.new
        books.each {|b| b.author = authors[rndAuthoe.rand(authors.size)].guid}
    end
    def generateTmpAuthors(a_n)
        generateTmpData(a_n) {addAuthor()}
    end
    def generateTmpOrders(a_n)
        rndReader = Random.new
        rndBook = Random.new
        for i in 1..a_n
            a = addOrder(books[rndBook.rand(books.size)].guid,
                readers[rndReader.rand(readers.size)].guid,
                Date.parse(Time.now.to_s))
        end
    end
    def readFromFile(a_path_to_file)
        File.open(a_path_to_file, 'r').each do |line|          
          a = yield 
          a.get_instance_variables_from_str(line)
        end
    end
    def saveOrders(a_path)
        a_path = path_to_orders if a_path == ''
        saveToFile(a_path, orders)
    end
    def saveBooks(a_path)
        a_path = path_to_books if a_path == ''
        saveToFile(a_path, books)
    end
    def saveAuthors(a_path)
        a_path = path_to_authors if a_path == ''
        saveToFile(a_path, authors)
    end
    def saveReaders(a_path)
        a_path = path_to_readers if a_path == ''
        saveToFile(a_path, readers)
    end
    def loadOrders(a_path)
        a_path = path_to_orders if a_path == ''
        readFromFile(a_path) {addOrder()}
    end
    def loadBooks(a_path)
        a_path = path_to_books if a_path == ''
        readFromFile(a_path) {addBook()}
    end
    def loadAuthors(a_path)
        a_path = path_to_authors if a_path == ''
        readFromFile(a_path) {addAuthor()}
    end
    def loadReaders(a_path)
        a_path = path_to_readers if a_path == ''
        readFromFile(a_path) {addReader()}
    end
    def loadAllData(a_path_to_books = '', a_path_to_authors = '', a_path_to_readers = '', a_path_to_orders = '')
        loadOrders(a_path_to_orders)
        loadBooks(a_path_to_books)
        loadAuthors(a_path_to_authors)
        loadReaders(a_path_to_readers)
    end
    def saveAllData(a_path_to_books = '', a_path_to_authors = '', a_path_to_readers = '', a_path_to_orders = '')
        saveOrders(a_path_to_orders)
        saveBooks(a_path_to_books)
        saveAuthors(a_path_to_authors)
        saveReaders(a_path_to_readers)
    end
    def get_item_by_guid(a_guid, a_collection)
        result = nil
        a1 = a_collection.select{|a| a.guid == a_guid}
        result = a1[0] if a1.size > 0
    end
    def get_most_popular_book
        a = orders.group_by{ |o| o.book}
        b = a.sort{|x,y| x[1, 1][0].size <=>y[1, 1][0].size}
        return get_item_by_guid(b[a.size-1][0], books)
    end

end
