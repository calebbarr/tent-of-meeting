class NTGreekWord < OriginalWord
	def inflections
		return NTGreekInflectedWord.where("strong_id=?",strong_id).all
	end 
end
