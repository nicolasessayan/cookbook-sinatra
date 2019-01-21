class View
  def user_input(string)
    puts string
    return gets.chomp
  end

  def display_recipes(array_of_recipes)
    array_of_recipes.each_with_index do |recipe, i|
      recipe.done ? done_output = "X" : done_output = " "
      puts "#{i + 1} - [#{done_output}] - Name: #{recipe.name} - Description: #{recipe.description} - Duration: #{recipe.duration} - Difficulty: #{recipe.difficulty}"
      puts "---------------------------"
    end
  end
end
