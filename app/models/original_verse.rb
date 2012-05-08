class OriginalVerse < ActiveRecord::Base
  belongs_to :verse
  searchable do
    text :content
  end  
end
