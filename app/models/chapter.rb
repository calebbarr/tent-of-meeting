class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :verses
  
  def self.lookup(book_id, chapter_name)
    return Book.find(book_id).chapters.where(:name => chapter_name).first
  end
  
  def next
    return id+1 <= NUMBER_OF_CHAPTERS ? Chapter.find(id+1) : self
  end
  
  def self.next(id)
    return id+1 <= NUMBER_OF_CHAPTERS ? Chapter.find(id+1) : Chapter.find(id)
  end
  
  def prev
    return id-1 > 0 ? Chapter.find(id-1) : Chapter.find(id)
  end
  
  def self.prev(id)
    return id-1 > 0 ? Chapter.find(id-1) : Chapter.find(id)
  end
  
  def islast?
    return id == NUMBER_OF_CHAPTERS
  end
  
  def link
    link = ""
  	link += "<a href='/"+book.name+"'>"+book.name.to_s+"</a>"
  	link += " <a href='/"+book.name+"/"+name.to_s+"'>"+name.to_s+"</a>"
    return link.html_safe
  end
  
  def path
    return "/"+book.name+"/"+name.to_s
  end
  
  def text
    text = ""
    verses.each do |verse|
      text += VerseText.find(verse.id).content + " "
    end
    return text
  end

  
end
