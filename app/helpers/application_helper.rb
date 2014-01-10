module ApplicationHelper
  def notice
    flash[:notice]
  end

  def alert
    flash[:alert]
  end
  
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"
  end
end
