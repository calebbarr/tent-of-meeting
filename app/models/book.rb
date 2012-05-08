class Book < ActiveRecord::Base
  has_many :chapters
  has_many :verses, :through => :chapters
  
  def next
    return id+1 <= NUMBER_OF_BOOKS ? Book.find(id+1) : Book.find(id)
  end
  
  def self.next(id)
    return id+1 <= NUMBER_OF_BOOKS ? Book.find(id+1) : Book.find(id)
  end
  
  def prev
    return id-1 > 0 ? Book.find(id-1) : Book.find(id)
  end
  
  def self.prev(id)
    return id-1 > 0 ? Book.find(id-1) : Book.find(id)
  end
  
  def islast?
    return id == NUMBER_OF_BOOKS
  end
  
  def link
    link = ""
  	link += "<a href='/"+name+"'>"+name.to_s+"</a>"
    return link.html_safe
  end
  
end