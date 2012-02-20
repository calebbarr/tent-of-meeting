class MultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :verse
  
  #DEFINITELY NEED VALIDATIONS HERE
  
  def self.random
    return MultipleChoiceQuestion.find(Random.new.rand(1..MultipleChoiceQuestion.count))
  end
  
end
