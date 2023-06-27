require './name_decorator'

class TrimmerDecorator < NameDecorator
  def correct_name
    name = @nameable.correct_name
    name[0...10]
  end
end
