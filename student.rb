require './person.rb'

class Student < Person
  def initialize(age, name='Unkown', classroom, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

end
