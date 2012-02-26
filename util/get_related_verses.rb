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
require '../app/models/related_verses'


books_to_urls = {
  "Song of Solomon" => "songs"
}

website_to_books = {
  "Psalm" => "Psalms",
  "Song of Songs" => "Song of Solomon"
}


hydra = Typhoeus::Hydra.new
related_verses_file = File.open("../resources/all_related_verses.rb", "w")
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
  
  (doc/"/html/body/table[2]/tr[1]/td[4]/table[1]/tr[1]/td[1]/p/b/a/text()").each do | reference|
      begin
      book_chapter_verse_array = reference.to_s.split(/\s(?=[0-9]+:[0-9]+)/)
      book_name_candidate = book_chapter_verse_array[0]
      book_name = website_to_books.has_key?(book_name_candidate) ? website_to_books[book_name_candidate]: book_name_candidate
      chapter_verse_array = book_chapter_verse_array[1].split(":")
      chapter_name = chapter_verse_array[0]
      verse_name = chapter_verse_array[1]
      book_id = Book.where("name=?",book_name).first.id
      related_verse = Verse.lookup(book_id,chapter_name,verse_name)
      related_verses_file.puts "RelatedVerses.create({ relatee_id: " + verse.id.to_s + " , related_id: " + related_verse.id.to_s + " })"
      RelatedVerses.create(relatee_id: verse.id, related_id: related_verse.id)
    rescue
      exceptions << {verse_id: verse.id, book_name: book_name, chapter_name: chapter_name, verse_name: verse_name, book_id: book_id, url: url}
    end
  end
end
exceptions.each do |exception|
  puts exception
end