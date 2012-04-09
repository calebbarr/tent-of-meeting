class ChatCell < TentOfMeetingCell
  def show
    @username = signed_in? ? current_user.email : "boo"
    render
  end

end
