class VerseHistoryRecord < ActiveRecord::Base
  belongs_to :user
  scope :current, where("updated_at >= ?", -> {POLLING_INTERVAL.seconds.ago.time}.call)
end
