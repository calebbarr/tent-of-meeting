class OriginalWord < ActiveRecord::Base
  paginates_per 100
  searchable do
    text :normalized_form
    text :form
  end
  
  def self.regex_search(query)
    return where("form ilike ?", "%#{query}%")
    #@TODO
    #not working for some reason
    # the regex operator is ~, maybe that will do some good
  end
  
end
