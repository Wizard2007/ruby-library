require './Models/author.rb'
require './Models/book.rb'
require './Models/order.rb'
require './Models/reader.rb'

class Library
    attr_accessor :books, :authors, :orders, :readers    
    def initialize()
        @books, @authors, @orders, @readers = [], [], [], []
    end
    def AddBook(a_name, a_biography, a_guid)
        book = Book.new(a_name, a_biography)
        book.guid = a_guid if a_guid
        books << book       
    end
    def AddAuthor(name, biography, a_guid)
        author = Author.new(name, biography)
        author.guid = a_guid if a_guid
        authors << author
    end
    def AddReader(a_name, a_email, a_city, a_street, a_house, a_guid)
        reader = Reader.new(a_name, a_email, a_city, a_street, a_house)
        reader.guid = a_guid if a_guid
        readers << reader
    end
    def AddOrder(a_book_guid, a_reader_guid, a_date, a_guid = nil)
        order = Order.new(a_book_guid, a_reader_guid, a_date)        
        puts order.to_s
        order.guid = a_guid if a_guid              
        orders << order        
    end
end