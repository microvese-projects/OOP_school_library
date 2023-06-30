class Rental
  attr_accessor :date, :book

  def person=(person)
    person.rentals.push(self) unless person.rentals.include?(self)
  end

  def book=(book)
    book.rentals.push(self) unless book.rentals.include?(self)
  end

  def initialize(date, book, person)
    @date = date
    @book = book
    self.person = person
    self.book = book
  end
end
