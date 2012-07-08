 require 'rubygems'
 require 'active_record'
 require 'typhoeus'
 require 'hpricot'

 # Load your yml config from rails
 db_config = YAML::load(File.open("../config/database.yml"))

 # Connect to the database, for me I only want this script to 
 # work in the development env..
 ActiveRecord::Base.establish_connection(db_config['development'])

 # Load your custom models that you created 
 # using ./script/generate, back in the days of yore...
 require '../app/models/verse'
 require '../app/models/book'
 require '../app/models/chapter'
 require '../app/models/search_helper'


 books_to_urls = {
   "Song of Solomon" => "songs"
 }

 website_to_books = {
   "Psalm" => "Psalms",
   "Song of Songs" => "Song of Solomon"
 }
 
 hydra = Typhoeus::Hydra.new
 search_helpers_file = File.open("../resources/all_search_helpers.rb", "w")
 exceptions = []
 index = 1
 percent = 0
 Verse.all.each do |verse|
   if index % 311 == 0 then
     percent+=1
     puts percent.to_s + "%"
   end
   index +=1
   chapter = verse.chapter
   book = chapter.book
   book_name = books_to_urls.has_key?(book.name) ? books_to_urls[book.name] : book.name.downcase.gsub(" ","_")
   url = "http://bible.cc/"
   url += book_name
   url += "/"
   url += chapter.name.to_s
   url+= "-"
   url += verse.name.to_s
   url += ".htm"

   request = Typhoeus::Request.new(url, :method => :get)
   hydra.queue(request)
   hydra.run
   response = request.response
   doc = Hpricot(response.body)
   xpath = "/html/body/table[2]/tr[1]/td[4]/table[1]/tr[1]/td[1]/p/text()"
   content = ""
   problems = []
   (doc/xpath).each do | verse_text|
     begin
      content += " " + verse_text.to_s
    rescue
      problems << verse_text
    end
   end
   begin
    SearchHelper.create(verse_id: verse.id, chapter_id: chapter.id, book_id: book.id, content: content)
    search_helpers_file.puts "SearchHelper.create({ verse_id: " + verse.id.to_s + " chapter_id: " + chapter.id.to_s + ", book_id: " + book.id.to_s + ", content: \"" + content.gsub("\"","\\\"") + "\" })"
  rescue
    exceptions << { verse.id => problems }
  end
 end
 puts "the following verses may have had problems creating search helpers"
 exceptions.each do |exception|
   puts exception
 end