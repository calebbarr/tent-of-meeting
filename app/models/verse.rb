class Verse < ActiveRecord::Base
  belongs_to :chapter
  has_many :verse_texts
  has_many :multiple_choice_questions
  
  def self.lookup(book_id,chapter_name,verse_name)
    return Book.find(book_id).verses.joins(:chapter).where("chapters.name=?",chapter_name).where(:name => verse_name).first
  end
  
  def self.random
    return Verse.find(Random.new.rand(1..NUMBER_OF_VERSES))
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
  
  def self.search(query)
    #needs to handle case variation
    query = "%"+query+"%"
    # VerseText.where("content like ?", query)
    # needs to return array of verses
    # probably going to need another SQL join
  end
  
  def has_quiz?
    return multiple_choice_questions.length > 0
  end
  
end
