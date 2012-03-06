class LXXInflectedWord < OriginalInflectedWord
  def base
		return LXXWord.where("strong_id=?",strong_id).first
	end
end