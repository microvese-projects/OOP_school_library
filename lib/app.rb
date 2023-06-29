require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
  end

  def list_books
    puts 'No books in the library!' if @books.empty?
    @books.each do |book|
      result = "Title: \"#{book.title.capitalize}\" "
      result += "Author: #{book.author.capitalize}"
      puts result
    end
  end

  def list_people
    puts 'No people registered!' if @people.empty?
    @people.each do |person|
      result = "[#{person.class.name}] "
      result += "Name: #{person.name.capitalize}, "
      result += "ID: #{person.id.to_s}, "
      result += "Age: #{person.age}"
      puts result
    end
  end

  def create_student(age, classroom, name = 'Unknown', parent_permission: true)
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @people.push(student)
  end

  def create_teacher(age, specialization, name = 'Unknown')
    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books.push(book)
  end

  def create_a_rental(date, book, person)
    Rental.new(date, book, person)
  end

  def list_person_rentals(id)
    @people.each do |person|
      puts person.rentals if person.id == id
    end
  end
end
