# frozen_string_literal: true

module Events
  class Update < ApplicationService
    attr_reader :user, :params, :event

    def initialize(user, event, params = {})
      @user = user
      @event = event
      @params = params
    end

    def call
      self.value = event_with_assigned_attributes

      event.save ? success(event) : failure(event.errors.full_messages)
    end

    private

    def utc_time_from_user_zone(user_time)
      return if user_time.blank?

      ActiveSupport::TimeZone.new(user.time_zone).local_to_utc(user_time)
    end

    def event_with_assigned_attributes
      event.assign_attributes(params)

      event.assign_attributes(
        starts_at: utc_time_from_user_zone(event.starts_at),
        ends_at: utc_time_from_user_zone(event.ends_at),
        notify_at: utc_time_from_user_zone(event.notify_at)
      )

      event
    end
  end
end
