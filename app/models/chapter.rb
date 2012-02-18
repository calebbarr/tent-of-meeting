class Chapter < ActiveRecord::Base
  belongs_to :book
  has_many :verses
  
  def self.lookup(book_id, chapter_name)
    return Book.find(book_id).chapters.where(:name => chapter_name).first
  end
  
end
