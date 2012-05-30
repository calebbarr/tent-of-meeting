class ChatCell < TentOfMeetingCell
  def show
    @username = signed_in? ? current_user.name : "anonymous"
    render
  end

end
