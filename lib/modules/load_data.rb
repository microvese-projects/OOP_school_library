require 'json'
require_relative '../book'
require_relative '../student'
require_relative '../teacher'
require_relative '../rental'

module Load
  def load_books
    return [] if File.exist?('files/books.json') == false
  
    new_arr = []
    file = File.read('files/books.json')
    file_data = JSON.parse(file)
    file_data.each do |book|
      new_arr << Book.new(book['title'], book['author'])
    end
    new_arr
  end
  
  def load_people
    return [] if File.exist?('files/people.json') == false
  
    new_arr = []
    file = File.read('files/people.json')
    file_data = JSON.parse(file)
    file_data.each do |person|
      new_arr << if person['class'] == 'Student'
                   Student.new(person['age'], nil, person['name'], person['id'],
                               parent_permission: person['parent_permission'])
                 else
                   Teacher.new(person['age'], person['specialization'], person['name'], person['id'])
                 end
    end
    new_arr
  end
  
  def load_rentals
    return [] if File.exist?('files/rentals.json') == false
  
    new_arr = []
    file = File.read('files/rentals.json')
    file_data = JSON.parse(file)
    file_data.each do |rental|
      date = rental['date']
      book = Book.new(rental['book']['title'], rental['book']['author'])
  
      p = rental['person']
      person = case p['class']
               when 'Student'
                 Student.new(p['name'], p['age'], nil, p['id'], parent_permission: p['parent_permission'])
               else
                 Teacher.new(p['name'], p['age'], p['specialization'], p['id'])
               end
  
      new_arr << Rental.new(date, book, person)
    end
    new_arr
  end
end