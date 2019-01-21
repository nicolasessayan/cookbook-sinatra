require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  array_names = []
  cookbook.all.each { |recipe| array_names << recipe.name }
  @usernames = array_names
  erb :index
end

get '/new' do
  erb :new
end

post '/form' do
  cookbook.add_recipe(Recipe.new(params[:name], params[:description], params[:duration], params[:difficulty]))
  redirect '/'
end

get '/about' do
  erb :about
end
