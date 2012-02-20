class VerseText < ActiveRecord::Base
  belongs_to :verse
  
  def self.search(query)
    return VerseText.where("content ilike ?", "%#{query}%")
  end
end
