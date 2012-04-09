class ChatCell < TentOfMeetingCell
  def show
    @username = signed_in? ? current_user.email : "anonymous"
    render
  end

end
