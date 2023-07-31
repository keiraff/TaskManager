# frozen_string_literal: true

class UsersController < AuthenticatedController
  def show
    @current_events = EventsQuery.call(events_scope, current_time: Time.current)
    @today_all_day_events = EventsQuery.call(events_scope, current_date: Time.zone.today)
    @pagy, @today_all_day_events = pagy(@today_all_day_events)
  end

  private

  def events_scope
    current_user.events
  end
end
