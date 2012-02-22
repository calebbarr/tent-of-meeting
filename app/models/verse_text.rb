class VerseText < ActiveRecord::Base
  belongs_to :verse
  paginates_per VERSE_SEARCH_RESULTS_PER_PAGE
  
  def self.search(query)
    return VerseText.where("content ilike ?", "%#{query}%")
  end
end
