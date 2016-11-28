require './Models/base_object.rb' 

class Author < BaseObject
    attr_accessor :name, :biography
    def initialize(guid: nil, name: '', biography: '')
        super({guid: guid})
        @name, @biography = name, biography
    end
    def self.add(option = {})
       Author.new(option)
    end
  def to_s
      "#{name}, #{biography}"
  end
end