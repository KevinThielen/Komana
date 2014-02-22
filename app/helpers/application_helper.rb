# coding: UTF-8
module ApplicationHelper
  def notice
    flash[:notice]
  end

  def alert
    flash[:alert]
  end
  
  def avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size.to_s}&d=#{CGI.escape("http://speed-rack.com/sites/default/files/default-user.png")}"
  end
  
  def create_temp_deleted_user
    @temp_user = User.new()
    @temp_user.firstname = "< Gelöschter"
    @temp_user.lastname = "Benutzer >"
    return @temp_user
  end
  
  def field_class(resource, field_name)
    if resource.errors[field_name].length > 0 
      return "form-group has-error".html_safe
    else
      return "form-group".html_safe
    end
  end
  

end
