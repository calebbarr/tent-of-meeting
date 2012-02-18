class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :verses
  
  def self.lookup(book_id, chapter_name)
    return Book.find(book_id).chapters.where(:name => chapter_name).first
  end
  
  def next
    return id+1 < NUMBER_OF_CHAPTERS ? Chapter.find(id+1) : self
  end
  
  def self.next(id)
    return id+1 < NUMBER_OF_CHAPTERS ? Chapter.find(id+1) : self
  end
  
  def prev
    return id-1 > 0 ? Chapter.find(id-1) : self
  end
  
  def self.prev(id)
    return id-1 > 0 ? Chapter.find(id-1) : self
  end
  
end
