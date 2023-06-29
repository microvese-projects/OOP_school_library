#!/usr/bin/env ruby

require './lib/app'

def age
  print 'Age: '
  age = gets.chomp
  if age == ''
    puts 'Age cannot be blank'
    print 'Age: '
    age = gets.chomp
  end
  age
end

def name
  print 'Name: '
  name = gets.chomp
  name = nil if name == ''
  name
end

def date
  print 'Date (yy/mm/dd): '
  gets.chomp
end

def permission
  print 'Has parent permission? [Y/N]: '
  permission = gets.chomp
  /y/i.match?(permission) == true
end

def specialization
  print 'Specialization: '
  gets.chomp
end

def create_person(app)
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  person = gets.chomp
  if person == '1' # create student
    age = age()
    name = name()
    permission = permission()

    app.create_student(age, nil, name, parent_permission: permission)
  elsif person == '2' # create teacher
    age = age()
    name = name()
    specialization = specialization()

    app.create_teacher(age, specialization, name)
  else
    puts 'You need to select an actual number'
    start(app)
  end
  puts 'Person created succesfully'
end

def display_persons(persons)
  persons.each_with_index do |person, index|
    result = "#{index}) "
    result += "[#{person.class.name}] "
    result += "Name: #{person.name.capitalize}, "
    result += "ID: #{person.id.to_s}, "
    result += "Age: #{person.age}"
    puts result
  end
end

def display_books(books)
  books.each_with_index do |book, index|
    result = "#{index}) "
    result += "Title: \"#{book.title.capitalize}\", "
    result += "Author: #{book.author.capitalize}"
    puts result
  end
end

def start_rental(app)
  books = app.books
  persons = app.people
  if books.empty? && persons.empty?
    puts 'Ensure you have books in library and people registered!' 
  else
    puts 'Select a book from the following list by number'
    display_books(books)
    
    book_index = gets.chomp.to_i
    
    puts 'Select a person from the following list by numnber (not id)'
    display_persons(persons)
    
    person_index = gets.chomp.to_i
    
    date = date()
    
    app.create_a_rental(date, app.books[book_index], app.people[person_index])
    puts 'Rental created succesfully!'
  end
end

def start(app = App.new())
  puts ' '
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - exit'
  puts ' '

  puts 'Please choose an option by enterin a number: '
  selection = gets.chomp

  check_selection(selection, app)
end

def check_selection(num, app)
  case num
  when '1' # list books
    app.list_books
    start(app)
  when '2' # list people
    app.list_people
    start(app)
  when '3' # create a person
    create_person(app)
    start(app)
  when '4' # create book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    app.create_book(title, author)
    puts 'Book created succesfully'
    start(app)
  when '5' # create rental
    start_rental(app)
    start(app)
  when '7' || /exit/i # exit app
    puts 'Exited!'
  else # Enter a valid number
    puts 'You must enter a valid number!'
    start(app)
  end
end

def main
  app = App.new
  puts 'Welcome to the School Library app!'

  start(app)
end

main
