class OriginalVerse < ActiveRecord::Base
  belongs_to :verse
  paginates_per VERSE_SEARCH_RESULTS_PER_PAGE
  searchable do
    text :content
  end  
end
