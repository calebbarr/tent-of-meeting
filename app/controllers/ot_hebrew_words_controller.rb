class OTHebrewWordsController < NavigationController
  def index
  end

  def show
    if params[:id] != nil then
      @original_word = OTHebrewWord.where("strong_id=?", params[:id]).first
    end
  end
end
