require_relative 'cookbook'
require_relative 'parsing'
require_relative 'view'

class Controller
  attr_reader :cookbook
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list(array_of_recipes)
    @view.display_recipes(array_of_recipes)
  end

  def create
    name_input = @view.user_input("What is the name of the recipe?")
    description_input = @view.user_input("What is the description of the recipe?")
    duration_input = @view.user_input("What is the duration time?")
    difficulty_input = @view.user_input("what is the difficulty?")
    @cookbook.add_recipe(Recipe.new(name_input, description_input, duration_input, difficulty_input))
  end

  def import
    puts "What is your keyword?"
    keyword_input = gets.chomp
    puts "What is the difficulty required?"
    difficulty_input = gets.chomp
    array_scrapped = ScrapeMarmitonService.new(keyword_input, difficulty_input).call
    list(array_scrapped)
    index_input = 0
    until (1..array_scrapped.length).cover?(index_input)
      puts "index of the recipe to add?"
      index_input = gets.chomp.to_i
      if (1..array_scrapped.length).cover?(index_input)
        @cookbook.add_recipe(array_scrapped[index_input - 1])
      else
        puts "index must be between 1 and #{array_scrapped.length}"
      end
    end
  end

  def mark
    index_input = 0
    until (1..@cookbook.all.length).cover?(index_input)
      puts "index of the recipe to mark as done?"
      index_input = gets.chomp.to_i
      if (1..@cookbook.all.length).cover?(index_input)
        @cookbook.mark_as_done(index_input - 1)
      else puts "index must be between 1 and #{@cookbook.all.length}"
      end
    end
  end

  def destroy
    index_input = 0
    if @cookbook.all.length == 0
      puts "nothing to destroy"
    elsif @cookbook.all.length == 1
      puts "are you sure you want to delete the last recipe?"
      answer = gets.chomp
      @cookbook.recipes = [] if answer == "yes"
    else
      until (1..@cookbook.all.length).cover?(index_input)
        puts "index of the recipe to destroy?"
        index_input = gets.chomp.to_i
        if (1..@cookbook.all.length).cover?(index_input)
          @cookbook.remove_recipe(index_input - 1)
        else puts "index must be between 1 and #{@cookbook.all.length}"
        end
      end
    end
  end
end
