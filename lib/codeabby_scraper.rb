require "codeabby_scraper/version"
require 'nokogiri'
require 'open-uri'
module CodeabbyScraper
  # Your code goes here...
  BASE = "http://www.codeabbey.com/index/task_view/"

  def get_problem(title)
  	doc = Nokogiri::HTML((open("#{BASE}#{title}")))
  	doc 
  end
end
