require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'modules/user_data'

class App
  include User

  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
  end

  def list_books(rent: false)
    puts 'No books in the library!' if @books.empty? && !rent
    @books.each_with_index do |book, index|
      result = ''
      result += "#{index}) " if rent
      result += "Title: \"#{book.title.capitalize}\" "
      result += "Author: #{book.author.capitalize}"
      puts result
    end
  end

  def list_people(rent: false)
    puts 'No people registered!' if @people.empty?
    @people.each_with_index do |person, index|
      result = ''
      result = "#{index}) " if rent
      result += "[#{person.class.name}] "
      result += "Name: #{person.name.capitalize}, "
      result += "ID: #{person.id}, "
      result += "Age: #{person.age}"
      puts result
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person = gets.chomp
    if person == '1' # create student
      age = age()
      name = name()
      permission = permission()

      student = Student.new(age, nil, name, parent_permission: permission)
      @people.push(student)
    elsif person == '2' # create teacher
      age = age()
      name = name()
      specialization = specialization()

      teacher = Teacher.new(age, specialization, name)
      @people.push(teacher)
    else
      puts 'You need to select an actual number'
      return
    end
    puts 'Person created succesfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created succesfully'
  end

  def create_a_rental
    books = @books
    persons = @people
    if books.empty? && persons.empty?
      puts 'Ensure you have books in library and people registered!'
    else
      puts 'Select a book from the following list by number'
      list_books(rent: true)

      book_index = gets.chomp.to_i

      puts 'Select a person from the following list by numnber (not id)'
      list_people(rent: true)

      person_index = gets.chomp.to_i

      date = date()

      Rental.new(date, @books[book_index], @people[person_index])
      puts 'Rental created succesfully!'
    end
  end

  def list_person_rentals
    print 'ID of person: '
    id = gets.chomp.to_i

    @people.each do |person|
      if person.id == id
        puts 'Rentals: '
        person.rentals.each do |rental|
          result = "Date: #{rental.date}, "
          result += "Book: \"#{rental.rented.title.capitalize}\" "
          result += "by #{rental.rented.author.capitalize}"
          puts result
        end
      else
        'No person with that ID!'
      end
    end
  end
end
