class OTHebrewWord < OriginalWord
	def inflections
		return OTHebrewInflectedWord.where("strong_id=?",strong_id).all
	end
	
  def link
    link = ""
  	link += "<a href='/hebrew/"+strong_id.to_s+"'>"+form+"</a>"
    return link.html_safe
  end
  
  def path
    return "/hebrew/"+strong_id.to_s.html_safe
  end
  
end
