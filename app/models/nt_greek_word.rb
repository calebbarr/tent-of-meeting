class NTGreekWord < OriginalWord
	def inflections
		return NTGreekInflectedWord.where("strong_id=?",strong_id).all
	end 
	
	def link
    link = ""
  	link += "<a href='/greek/"+strong_id.to_s+"'>"+form+"</a>"
    return link.html_safe
  end
  
  def path
    return "/greek/"+strong_id.to_s.html_safe
  end
end
