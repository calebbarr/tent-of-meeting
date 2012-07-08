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
  require '../app/models/search_helper'


 books_to_urls = {
   "Song of Solomon" => "songs"
 }

 website_to_books = {
   "Psalm" => "Psalms",
   "Song of Songs" => "Song of Solomon"
 }