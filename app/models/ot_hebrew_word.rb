class OTHebrewWord < OriginalWord
	def inflections
		return OTHebrewInflectedWord.where("strong_id=?",strong_id).all
	end	
end
