# frozen_string_literal: true

module EventsTimeZone
  extend ActiveSupport::Concern

  def set_time_zone(&)
    time_zone = current_user.time_zone
    if time_zone.present?
      Time.use_zone(time_zone, &)
    else
      yield
    end
  end
end
