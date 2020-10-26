module ApplicationHelper
  # For generating time tags calculated using jquery.timeago
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  # Shortcut for outputing proper ownership of objects,
  # depending on who is looking
  def whose?(user, object)
    case object
      when Post
        owner = object.user
      else
        owner = nil
    end
    if user and owner
      if user.id == owner.id
        "hens"
      else
        "#{owner.nickname}'s"
      end
    else
      ""
    end
  end

  # Check if object still exists in the database and display a link to it,
  # otherwise display a proper message about it.
  # This is used in activities that can refer to
  # objects which no longer exist, like removed posts.
  def link_to_trackable(object, object_type)
    if object
      link_to object_type.downcase, object
    else
      "#{object_type.downcase} som har blivit borttagen sen dess"
    end
  end

  def belongs_to_user?(resource)
    resource.user == current_user
  end

  def activity_resources_exist?(activity)
    activity && activity.trackable && activity.owner
  end

  def relative_time(datetime)
    time_ago_in_words(datetime)
  end

  def formatted_time(time)
    time.to_formatted_s(:short)
  end

  def find_like(likeable)
    likeable.get_likes.where(user: current_user)
  end

  def is_current_user?(user)
    user == current_user
  end
end
