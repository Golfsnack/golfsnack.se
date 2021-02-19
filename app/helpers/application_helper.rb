module ApplicationHelper
  def belongs_to_user?(resource)
    resource.user == current_user
  end

  def relative_time(datetime)
    time_ago_in_words(datetime)
  end

  def is_current_user?(user)
    user == current_user
  end

  def meta_title
    content_for(:meta_title) || "Golfsnack.se - Av golfare för golfare"
  end

  def meta_description
    content_for(:meta_description) || "Sveriges roligaste community för dig som gillar allt kring golf"
  end

  def meta_image
    content_for(:meta_image) || image_url("og.jpg")
  end

  def meta_url
    content_for(:meta_url) || "https://golfsnack.se"
  end

  def meta_type
    content_for(:meta_type) || "website"
  end
end
