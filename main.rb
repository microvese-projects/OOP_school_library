#!/usr/bin/env ruby

require './lib/app'

def list_books(app)
  app.list_books
end

def list_people(app)
  app.list_people
end

def create_person(app)
  app.create_person
end

def create_book(app)
  app.create_book
end

def start_rental(app)
  app.create_a_rental
end

def display_rentals(app)
  app.list_person_rentals
end

def start(app = App.new())
  puts ' '
  puts 'Please choose an option by enterin a number: '
  puts ' '
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - exit'
  puts ' '

  selection = gets.chomp

  check_selection(selection, app)
end

def check_selection(num, app)
  menu_options = {
    '1' => method(:list_books),
    '2' => method(:list_people),
    '3' => method(:create_person),
    '4' => method(:create_book),
    '5' => method(:start_rental),
    '6' => method(:display_rentals)
  }

  action = menu_options[num]
  if action
    action.call(app)
  elsif num == '7'
    puts 'Thank you for using this app!'
    return
  else
    puts 'You must enter a valid number!'
  end

  start(app)
end

def main
  app = App.new
  puts 'Welcome to the School Library app!'

  start(app)
end

main
