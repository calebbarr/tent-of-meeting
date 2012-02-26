class RelatedVerses < ActiveRecord::Base
  belongs_to :relatee, :class_name => "Verse", :foreign_key => "relatee_id"
  belongs_to :related, :class_name => "Verse", :foreign_key => "related_id"
  belongs_to :verse, :foreign_key => "relatee_id"
end
