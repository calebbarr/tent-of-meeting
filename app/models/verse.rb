class Verse < ActiveRecord::Base
  belongs_to :chapter
  has_many :verse_text
  
  def self.lookup(book_id,chapter_name,verse_name)
    return Book.find(book_id).verses.joins(:chapter).where("chapters.name=?",chapter_name).where(:name => verse_name).first
  end
  
end
