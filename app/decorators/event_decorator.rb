# frozen_string_literal: true

module EventDecorator
  def decorated_starts_at_date
    in_current_user_time_zone(starts_at).to_date.to_fs(:long_ordinal)
  end

  def decorated_starts_at
    in_current_user_time_zone(starts_at).to_fs(:long)
  end

  def decorated_ends_at
    in_current_user_time_zone(ends_at).to_fs(:long)
  end

  def decorated_time_interval
    if all_day
      in_current_user_time_zone(starts_at).to_date.to_fs(:long_ordinal)
    else
      "#{in_current_user_time_zone(starts_at).to_fs(:long)} - #{in_current_user_time_zone(ends_at).to_fs(:long)}"
    end
  end

  def decorated_notify_at
    return if notify_at.blank?

    "Notification is set on #{in_current_user_time_zone(notify_at).to_fs(:short)}"
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

  def starts_at_for_new_page
    in_current_user_time_zone(1.minute.from_now)
  end

  def starts_at_for_edit_page
    in_current_user_time_zone(starts_at)
  end

  def ends_at_for_edit_page
    all_day? ? nil : in_current_user_time_zone(ends_at)
  end

  def notify_at_for_edit_page
    notify_at.present? ? in_current_user_time_zone(notify_at) : nil
  end

  def decorated_start_year
    in_current_user_time_zone(Date.current).year
  end

  private

  def in_current_user_time_zone(time)
    time.in_time_zone(current_user.time_zone)
  end
end
