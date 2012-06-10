class StrongsController < NavigationController
  def index
    set_mode(:strongs)
  end
  
  def greek
    @greek_words = NTGreekWord.where("strong_id>=?",1).order("strong_id").page(params[:page])
  end
  
  def hebrew
    @hebrew_words = OTHebrewWord.where("strong_id>=?",1).order("strong_id").page(params[:page])
  end

end
