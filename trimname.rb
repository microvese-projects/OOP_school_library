require "./name_decorator"

class TrimmerDecorator < Name_decorator
  def correct_name 
    name = @nameable.correct_name
    name[0...10]
  end
end
