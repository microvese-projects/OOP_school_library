module User
  def age
    print 'Age: '
    age = gets.chomp
    if age == ''
      puts 'Age cannot be blank'
      age
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
    date = gets.chomp
    if date == ''
      puts 'A date is required!'
      date
    end
    date
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
end
