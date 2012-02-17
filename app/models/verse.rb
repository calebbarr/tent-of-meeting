class Verse < ActiveRecord::Base
  belongs_to :chapter
  has_many :verse_text
end
