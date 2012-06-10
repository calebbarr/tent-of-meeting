class ChatCell < TentOfMeetingCell
  def show
    @user = {}
    @user[:name] = signed_in? ? current_user.name : "anonymous"
    @user[:image_url] = signed_in? ? current_user.image_url(:icon) : "http://localhost:3000/icons/16x16/user.png"
    render
  end

end
