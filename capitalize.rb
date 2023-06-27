require './name_decorator'

class CapitalizeDecorator < NameDecorator
  def correct_name
    name = @nameable.correct_name
    name.capitalize
  end
end
