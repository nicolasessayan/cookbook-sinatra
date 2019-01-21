require 'csv'
require_relative 'recipe'

class Cookbook
  attr_writer :recipes

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path) { |row| @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4] == "true") }
  end

  def save(csv_file_path)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.duration, recipe.difficulty, recipe.done] }
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save(@csv_file_path)
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].mark_as_done
    save(@csv_file_path)
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save(@csv_file_path)
  end
end

# pizza = Recipe.new("Pizza", "Italian specialty")
# burger = Recipe.new("Burger", "The US in your plate")
# my_cookbook = CookBook.new(File.join(__dir__, 'recipes.csv'))
# p my_cookbook.all
# my_cookbook.add_recipe(pizza)
# my_cookbook.add_recipe(burger)
# p my_cookbook
