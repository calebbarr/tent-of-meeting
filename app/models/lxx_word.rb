class LXXWord < OriginalWord
  def inflections
		return LXXInflectedWord.where("strong_id=?",strong_id).all
	end
end