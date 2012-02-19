class Verse < ActiveRecord::Base
  belongs_to :chapter
  has_many :verse_text
  
  def self.lookup(book_id,chapter_name,verse_name)
    return Book.find(book_id).verses.joins(:chapter).where("chapters.name=?",chapter_name).where(:name => verse_name).first
  end
  
  def self.random
    index = rand(1..NUMBER_OF_VERSES)
    return Verse.find(index)
  end
  
  def next
    return id+1 <= NUMBER_OF_VERSES ? Verse.find(id+1) : Verse.find(id)
  end
  
  def self.next(id)
    return id+1 <= NUMBER_OF_VERSES ? Verse.find(id+1) : Verse.find(id)
  end
  
  def prev
    return id-1 > 0 ? Verse.find(id-1) : Verse.find(id)
  end
  
  def self.prev(id)
    return id-1 > 0 ? Verse.find(id-1) : Verse.find(id)
  end
  
end
