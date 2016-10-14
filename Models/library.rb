require './Models/author.rb'
require './Models/book.rb'
require './Models/order.rb'
require './Models/reader.rb'

class Library
    attr_accessor :books, :authors, :orders, :readers    
    def initialize()
        @books, @authors, @orders, @readers = [], [], [], []
    end
    def AddBook(a_name = '', a_biography = '', a_guid = nil)
        book = Book.new(a_name, a_biography)
        book.guid = a_guid if a_guid
        books << book
        return book
    end
    def AddAuthor(name = '', biography = '', a_guid = nil)
        author = Author.new(name, biography)
        author.guid = a_guid if a_guid
        authors << author
        return author
    end
    def AddReader(a_name = '', a_email = '', a_city = '', a_street = '', a_house = '', a_guid = nil)
        reader = Reader.new(a_name, a_email, a_city, a_street, a_house)
        reader.guid = a_guid if a_guid
        readers << reader
        return reader
    end
    def AddOrder(a_book_guid = '', a_reader_guid = '', a_date = nil, a_guid = nil)
        order = Order.new(a_book_guid, a_reader_guid, a_date)                
        order.guid = a_guid if a_guid              
        orders << order
        return order
    end
    def SaveToFile(a_path_to_file, a_collection)       
        f = File.new(a_path_to_file, "w+")
        a_collection.each{|a| f.puts a.get_as_delimetered_str}        
    end    
    def ReadFromFile(a_path_to_file)
        #puts 'Read From File'      
        
        File.open(a_path_to_file, 'r').each do |line|          
          a = yield 
          a.get_instance_variables_from_str(line)
        end
    end
end