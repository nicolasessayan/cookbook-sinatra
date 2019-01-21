require "open-uri"
require "nokogiri"
require_relative 'recipe'

# def scrape_craiglist_antiques(city)
#   # TODO: return an array of Antiques found of Craiglist for this `city`.
#   array = []
#   url = "https://#{city}.craigslist.org/d/antiques/search/ata?"
#   html_content = open(url).read
#   doc = Nokogiri::HTML(html_content)

#   doc.search('a.result-title.hdrlnk').each do |element|
#     array << element.text.strip
#   end
#   return array
# end

# # p scrape_craiglist_antiques("paris")
# # p scrape_craiglist_antiques("newyork")

class ScrapeMarmitonService
  def initialize(keyword, difficulty)
    @keyword = keyword
    @difficulty = difficulty
  end

  def call
    array_name = []
    array_description = []
    array_duration = []
    array_recipe = []
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@keyword}&dif=#{@difficulty}"
    doc = Nokogiri::HTML(open(url).read)
    doc.search('h4.recipe-card__title').each { |element| array_name << element.text.strip }
    doc.search('div.recipe-card__description').each { |element| array_description << element.text.strip }
    doc.search('span.recipe-card__duration__value').each { |element| array_duration << element.text.strip }
    (0..4).each { |i| array_recipe << Recipe.new(array_name[i], array_description[i], array_duration[i], @difficulty) }
    return array_recipe
  end
end

# my_scrape = ScrapeMarmitonService.new("fromage", 1)
# p my_scrape.call
# https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=fromage&dif=2&dif=3&dif=4
