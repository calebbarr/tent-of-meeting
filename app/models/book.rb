class Book < ActiveRecord::Base
  has_many :chapters
  has_many :verses, :through => :chapters
  
  def next
    return id+1 < NUMBER_OF_BOOKS ? Book.find(id+1) : self
  end
  
  def self.next(id)
    return id+1 < NUMBER_OF_BOOKS ? Book.find(id+1) : self
  end
  
  def prev
    return id-1 > 0 ? Book.find(id-1) : self
  end
  
  def self.prev(id)
    return id-1 > 0 ? Book.find(id-1) : self
  end
  
end