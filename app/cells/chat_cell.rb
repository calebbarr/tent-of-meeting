class ChatCell < TentOfMeetingCell
  def show
    @username = signed_in? ? current_user.name : "anonymous"
    puts current_user.name
    puts "ASDAS WJAT UP"
    puts current_user.email
    puts current_user.name
    render
  end

end
