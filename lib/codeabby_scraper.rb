require "codeabby_scraper/version"
require 'nokogiri'
require 'open-uri'
module CodeabbyScraper
  # Your code goes here...
  BASE = "http://www.codeabbey.com/index/task_view/"
  class ProblemNotFound < StandardError; end

  class << self 
  	attr_accessor :doc, :body_text
   def new(title)
   	begin
  	 @doc = Nokogiri::HTML((open("#{BASE}#{title}")))
  	 @body_text = @doc.xpath('//*[@dir="ltr"]')
  	rescue OpenURI::HTTPError => e
  	  raise ProblemNotFound
  	end
   end
	
   def markdown_text
      text ="" 
   	  @body_text.children.each do |elem|
   	  	if elem.name == 'pre'
   	  		text << "```#{elem.text}```"
   	  	else 
   	  	  text << elem.text
   	  	end
   	  end
   	  text
   end 

   def test_input
     str = @body_text.xpath('//code[contains(text(), "input data")]').text
     str.gsub!("input data:\n", '')
     str.gsub!(/\n\nanswer:\n.+\n/, '')
     str
   end   

   def answer 
   	str = @body_text.xpath('//code[contains(text(), "input data")]').text
   	str_match = str.match(/\n\nanswer:\n.+/).to_s
   	str_match = str_match.gsub!(/\n\nanswer:\n/, '')
   	str_match
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
