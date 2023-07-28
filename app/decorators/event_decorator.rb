# frozen_string_literal: true

module EventDecorator
  def decorated_starts_at_date
    starts_at.to_date.to_fs(:long_ordinal)
  end

  def decorated_starts_at
    starts_at.to_fs(:long)
  end

  def decorated_ends_at
    ends_at.to_fs(:long)
  end

  def decorated_time_interval
    if all_day
      starts_at.to_date.to_fs(:long_ordinal)
    else
      "#{starts_at.to_fs(:long)} - #{ends_at.to_fs(:long)}"
    end
  end

  def decorated_notify_at
    return if notify_at.blank?

    "Notification is set on #{notify_at.to_fs(:short)}"
  end

  def truncated_name
    truncate(name, length: 30)
  end

  def truncated_description
    truncate(description, length: 200)
  end

  def decorated_category_tag
    "##{category.name}"
  end
end
