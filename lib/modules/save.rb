require_relative '../save_data'

module Save
  def save_books(arr)
    new_arr = []
    arr.each do |book|
      obj = {
        title: book.title,
        author: book.author
      }
      new_arr << obj
    end
    save(new_arr, 'books')
  end

  def save_people(arr)
    new_arr = []
    arr.each do |person|
      obj = if person.instance_of?(::Student)
              obj_student(person)
            else
              obj_teacher(person)
            end
      new_arr << obj
    end
    save(new_arr, 'people')
  end

  def save_rentals(arr)
    new_arr = []
    arr.each do |rental|
      obj = rental_obj(rental)
      new_arr << obj
    end
    save(new_arr, 'rentals')
  end

  def obj_student(person)
    {
      class: person.class,
      id: person.id,
      name: person.name,
      age: person.age,
      parent_permission: person.parent_permission,
      rentals: person.rentals
    }
  end

  def obj_teacher(person)
    {
      class: person.class,
      id: person.id,
      name: person.name,
      age: person.age,
      specialization: person.specialization,
      rentals: person.rentals
    }
  end

  def rental_obj(rental)
    if rental.person.class == 'Student'
      return {
        date: rental.date,
        book: {
          title: rental.book.title,
          author: rental.book.author,
          rentals: rental.book.rentals
        },
        person: obj_student(rental.person)
      }
    else
      return {
        date: rental.date,
        book: {
          title: rental.book.title,
          author: rental.book.author,
          rentals: rental.book.rentals
        },
        person: obj_teacher(rental.person)
      }
    end
  end

end