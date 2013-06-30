class Library
  attr_accessor :shelves
  
  def initialize(shelves=[])
    if shelves.instance_of? Array
      shelves.each do |shelf|
        if shelf.instance_of? Shelf or shelf.nil?
          @shelves = shelves
        else
          puts "Improper shelves attribute: shelves should only contain Shelf objects. Library not created."
          raise ArgumentError
        end
      end
    else
      puts "Improper shelves attribute: shelves should be an array. Library not created."
      raise ArgumentError
    end
  end
  
  def get_books
    shelves.collect {|shelf| shelf.get_books}
  end
end

class Shelf
  attr_accessor :books

  def initialize(books=[])
    if books.instance_of? Array
      books.each do |book|
        if book.instance_of? Book or book.nil?
          @books = books
        else
          puts "Improper books attribute: books should only contain Book object(s). Shelf not created."
          raise ArgumentError
        end
      end
    end
  end
  
  def add_book(book)
    if books.instance_of? Array
      books.push(book)
    else
      books = []
      books.push(book)
    end
  end
  
  def remove_book(book)
    if books.instance_of? Array
      books.delete(book) {print "This book is not on the shelf."}
    else
      books = []
    end
  end
  
  def get_books
    books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end
end

class Book
  # For simplicity, assume that each book is uniquely defined by their title and author.
  # Additional attributes which uniquely define a book can be easily added if desired.
  attr_accessor :title
  attr_accessor :author
  attr_accessor :bookshelf
  
  def initialize(title, author, bookshelf=nil)
    @title = title
    @author = author
  end
  
  def shelf(some_shelf)
    if some_shelf.books.include?(self)
      puts "#{title} by #{author} is already on this shelf and does not require shelving again."
    else
      some_shelf.add_book(self)
    end
  end
  
  def unshelf(some_shelf)
    some_shelf.remove_book(self)
  end
end


# Some examples

puts '** CREATE NEW BOOKS **'
mark_twain = Book.new("Smthg Smthg","Mark Twain")
dr_seuss = Book.new('Green Eggs and Ham', 'Dr. Seuss')
beta = Book.new('Beta','Amy')
puts mark_twain, dr_seuss, beta
puts '** CREATE NEW SHELVES, MY_SHELF AND MY_SHELF2 **'
my_shelf = Shelf.new([mark_twain, dr_seuss])
my_shelf2 = Shelf.new([Book.new('Fishalish','Mr. Delish'),Book.new('Lala','Mozart')])
puts 'my_shelf:'
puts my_shelf
puts 'my_shelf2:'
puts my_shelf2
puts '** TRY SHELVING BOOKS ONTO THE SAME SHELF THEY ARE ON. OBTAIN ERROR MESSAGE **'
dr_seuss.shelf(my_shelf)
mark_twain.shelf(my_shelf)
puts '** REPORT ON ALL BOOKS ON MY_SHELF SO FAR **'
my_shelf.get_books
puts "** SHELF A NEW BOOK ONTO MY_SHELF AND REPORT ON ALL BOOKS ON MY_SHELF **"
beta.shelf(my_shelf)
my_shelf.get_books
puts '** DEFINE NEW LIBRARY WITH SHELVES MY_SHELF and MY_SHELF2'
my_lib = Library.new([my_shelf,my_shelf2])
puts my_lib
puts '** REPORT ON ALL BOOKS IN LIBRARY **'
my_lib.get_books