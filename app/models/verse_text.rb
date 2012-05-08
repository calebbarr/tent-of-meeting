class VerseText < ActiveRecord::Base
  belongs_to :verse
  paginates_per VERSE_SEARCH_RESULTS_PER_PAGE
  searchable do
    text :content
  end
  
  def self.regex_search(query)
    return VerseText.where("content ilike ?", "%#{query}%")
  end
end
