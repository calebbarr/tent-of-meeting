class MultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :verse
  validates_presence_of :content,:a,:b,:c,:d,:correct,:verse_id
  validates_presence_of :correct, :message => "One answer needs to be marked as correct."
  validates_format_of :correct, :with => /a|b|c|d/, :message => "One answer needs to be marked as correct."
  validates_format_of :content, :with => /According to [A-Z]+[a-z]* [0-9]+:[0-9]+, .*\?/, :message => "Question must be of the format \"According to Book chapter:verse, [question]?\""
  validates_length_of :content, :minimum => 7, :tokenizer => lambda {|str| str.scan(/\w+/) }, :message => "Question should be at least 7 words long."
  
  def self.random
    return MultipleChoiceQuestion.find(Random.new.rand(1..MultipleChoiceQuestion.count))
  end
  
end
