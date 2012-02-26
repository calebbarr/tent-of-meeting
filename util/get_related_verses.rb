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

hydra = Typhoeus::Hydra.new
Verse.all.each do |verse|
  chapter = verse.chapter
  book = chapter.book
  book_name = book.name == "Song of Solomon" ? "songs" : book.name.downcase.gsub(" ","_")
  url = "http://concordances.org/"
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
  puts url
  (doc/"/html/body/table[2]/tr[1]/td[4]/table[1]/tr[1]/td[1]/p/b/a/text()").each do | reference|
    puts reference.to_s
  end
end