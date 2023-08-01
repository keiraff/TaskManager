# frozen_string_literal: true

module Users
  class Show < ApplicationService
    attr_reader :user, :params

    def initialize(user, params = {})
      @user = user
      @params = params
    end

    def call
      success(
        {
          today_all_day_events: today_all_day_events,
          current_events: current_events,
        }
      )
    end

    private

    def today_all_day_events
      @today_all_day_events ||= events_scope.where(starts_at: params[:time].all_day).where(all_day: true)
    end

    def current_events
      @current_events ||= events_scope.where(starts_at: ...params[:time], ends_at: params[:time]...)
    end

    def events_scope
      user.events
    end
  end
end
