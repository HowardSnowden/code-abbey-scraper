require "codeabby_scraper/version"
require 'nokogiri'
require 'open-uri'
module CodeabbyScraper
  # Your code goes here...
  BASE = "http://www.codeabbey.com/index/task_view/"

  class << self 
   def get_problem(title)
  	@doc = Nokogiri::HTML((open("#{BASE}#{title}")))
   
  end

   def dirname
   	 begin 
  	  @doc.css('h1').first.text.downcase.gsub!(' ', '_')
  	 rescue 
  	 	raise "No valid title could be found"
  	 end
   end
 end
end
