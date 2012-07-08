class SearchHelper < ActiveRecord::Base
  belongs_to :verse
  searchable do
    text :content
    integer :verse_id
    integer :chapter_id
    integer :book_id
  end
end
