# frozen_string_literal: true

class UsersController < AuthenticatedController
  def show
    result = Users::Show.call(current_user, { time: Time.current })

    @today_all_day_events_count = result.value[:today_all_day_events].count
    @current_events_count = result.value[:current_events].count

    @pagy_today_all_day_events, @today_all_day_events = pagy(result.value[:today_all_day_events],
                                                             page_param: :today_all_day_events_page)
    @pagy_current_events, @current_events = pagy(result.value[:current_events], page_param: :current_events_page)
  end
end
