require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'modules/user_data'
require_relative 'modules/save'
require_relative 'modules/load_data'

class App
  include User
  include Save
  include Load

  attr_accessor :books, :people

  def initialize
    @books = load_books
    @people = load_people
    @rentals = load_rentals
  end

  def list_books(rent: false)
    puts '|---------LIST OF BOOKS-----------|'
    puts ' '
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
    puts '|---------LIST OF PEOPLE-----------|'
    puts ' '
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
      puts "|---------CREATE STUDENT-----------|\n\n"
      age = age()
      name = name()
      permission = permission()
      @people << Student.new(age, nil, name, nil, parent_permission: permission)
    elsif person == '2' # create teacher
      puts "|---------CREATE TEACHER-----------|\n\n"
      age = age()
      name = name()
      specialization = specialization()
      @people << Teacher.new(age, specialization, name, nil)
    else
      puts 'You need to select an actual number'
      return
    end
    puts 'Person created succesfully'
  end

  def create_book
    puts "|---------CREATE A BOOK-----------|\n\n"
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
      puts '|-----------------------RENTALS---------------------------|'
      puts '  Ensure you have books in library and people registered!  '
    else
      puts 'Select a book from the following list by number'
      list_books(rent: true)

      book_index = gets.chomp.to_i

      puts 'Select a person from the following list by numnber (not id)'
      list_people(rent: true)

      person_index = gets.chomp.to_i

      date = date()

      @rentals << Rental.new(date, @books[book_index], @people[person_index])
      puts 'Rental created succesfully!'
    end
  end

  def list_person_rentals
    list_people
    print 'ID of person: '
    id = gets.chomp.to_i

    person = @people.select { |each| each.id == id }[0]
    puts person

    if person
      puts "\n|------------RENTALS ID: #{id}----------|"
      puts '  Rentals: '
      person.rentals.each do |rental|
        result = "Date: #{rental.date}, "
        result += "Book: \"#{rental.book.title.capitalize}\" "
        result += "by #{rental.book.author.capitalize}"
        puts result
      end
    else
      puts '|-----------OOPS!------------|'
      puts "  No person with id: #{id}!  "
      puts '|-----------OOPS!------------|'
    end
  end

  def quit
    save_books(@books)
    save_people(@people)
    save_rentals(@rentals)
  end
end
