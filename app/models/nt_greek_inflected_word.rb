class NTGreekInflectedWord < OriginalInflectedWord
  def base
		return NTGreekWord.where("strong_id=?",strong_id).first
	end
end