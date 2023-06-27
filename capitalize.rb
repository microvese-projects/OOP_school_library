require "./name_decorator"

class CapitalizeDecorator < Name_decorator
  def correct_name
    name = @nameable.correct_name
    name.capitalize()
  end
end
