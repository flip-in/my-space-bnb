module ApplicationHelper
  def avatar_for(user, data = {})
    @avatar = user.avatar
    if @avatar.attached?
      @avatar_user = cl_image_tag(@avatar.key, data)
    else
      @avatar_user = image_tag("yoda.png", data)
    end
    return @avatar_user
  end

  def random_avatar(data = {})
    @avatar = image_tag("avatar/#{rand(6)}.png",data) 
    return @avatar 
  end
end
