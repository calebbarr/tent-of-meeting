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
require '../app/models/original_verse'
require '../app/models/ot_hebrew_verse'
require '../app/models/nt_greek_verse'


books_to_urls = {
  "Song of Solomon" => "songs"
}

hydra = Typhoeus::Hydra.new
original_verses_file = File.open("../resources/all_original_verses.rb", "w")
exceptions = []
index = 0
percent = 0
puts percent.to_s + "%"
Verse.all.each do |verse|
  if index % 311 == 0 then
    percent+=1
    puts percent.to_s + "%"
  end

  chapter = verse.chapter
  book = chapter.book
  book_name = books_to_urls.has_key?(book.name) ? books_to_urls[book.name] : book.name.downcase.gsub(" ","_")
  
  url = "http://biblos.com/"
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
  
  content = ""
  strong_ids = ""
  begin
    (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td/table/tr[2]/td/div[2]/span/span").each do |span|
        content += (span/"text()").to_s + " "
        begin
          strong_ids += (span/"a").to_s.split()[1].split("/")[4].split("\.")[0] + " "
          #for some reason the xpath isn't working to get the href attribute
        rescue
          exceptions << {verse_id: verse.id, book_name: book_name, chapter_name: chapter.name, verse_name: verse.name, book_id: book.id.to_s, url: url, span: span.to_s}
        end
    end
    index += 1
    if verse.id < 23146 then
      original_verses_file.puts "OTHebrewVerse.create({ strong_ids: \"" + strong_ids + "\" , content: \"" + content + "\" , verse_id: "+index.to_s+" })"
      OTHebrewVerse.create(content: content, strong_ids: strong_ids, verse_id: index)
    else
      original_verses_file.puts "NTGreekVerse.create({ strong_ids: \"" + strong_ids + "\" , content: \"" + content + "\" , verse_id: "+index.to_s+" })"
      NTGreekVerse.create(content: content, strong_ids: strong_ids, verse_id: index)
    end
  rescue
    exceptions << {verse_id: verse.id, book_name: book_name, chapter_name: chapter.name, verse_name: verse.name, book_id: book.id.to_s, url: url}
  end
  
end
exceptions.each do |exception|
  puts exception
end