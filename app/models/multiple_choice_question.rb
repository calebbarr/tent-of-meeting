class MultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :verse
  validates_presence_of :content,:a,:b,:c,:d,:correct
  validates_format_of :correct, :with => /a|b|c|d/
  
  def self.random
    return MultipleChoiceQuestion.find(Random.new.rand(1..MultipleChoiceQuestion.count))
  end
  
end
