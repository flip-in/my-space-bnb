module ApplicationHelper
  def avatar_for_navbar(user)
    @avatar = user.avatar
    if @avatar.attached?
      @avatar_user = cl_image_tag(@avatar.key, height: 40, width: 40)
    else
      @avatar_user = image_tag("yoda.png", height: 40, width: 40)
    end
    return @avatar_user
  end

  def avatar_for_background(user)
    @avatar = user.avatar
    if @avatar.attached?
      @avatar_user = cl_image_path(@avatar.key)
    else
      @avatar_user = image_path("yoda.png")
    end
    return @avatar_user
  end
end
