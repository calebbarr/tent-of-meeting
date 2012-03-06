class OTHebrewInflectedWord < OriginalInflectedWord
  def base
		return OTHebrewWord.where("strong_id=?",strong_id).first
	end
end
