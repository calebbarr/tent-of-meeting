class OriginalVerse < ActiveRecord::Base
  belongs_to :verse
  paginates_per 20
end
