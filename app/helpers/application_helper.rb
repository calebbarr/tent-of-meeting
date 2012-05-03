module ApplicationHelper
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://tent-of-meeting-faye.herokuapp.com/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
  
  #returns a javascript, constructed from data to which only the ruby has access
  def toggle_original_languages_script
    javascript = "toggle_original_language("
    if @verse.nt? then
      javascript += "true"
    else
      javascript += "false"
    end
    javascript+=");"
    # javascript += "location.reload();"
    return javascript
  end
  
end
