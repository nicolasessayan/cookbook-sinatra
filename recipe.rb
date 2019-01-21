class Recipe
  attr_reader :name, :description, :duration, :difficulty, :done

  def initialize(name, description, duration, difficulty, done = false)
    @name = name
    @description = description
    @duration = duration
    @difficulty = difficulty
    @done = done
  end

  def mark_as_done
    @done = true
  end
end
