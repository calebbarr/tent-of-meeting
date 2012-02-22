require 'rubygems'
require 'active_record'

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

book_name = ARGV[0]
chapter_name = ARGV[1]
verse_name = ARGV[2]
book_id = Book.where("name=?",book_name)
print Verse.lookup(book_id,chapter_name,verse_name).id