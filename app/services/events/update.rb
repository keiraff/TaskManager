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

      if event.save
        update_email_notification

        success(event)
      else
        failure(event.errors.full_messages)
      end
    end

    private

    def update_email_notification
      result = EmailNotifications::Update.call(event_id: event.id, user_id: user.id, notify_at: event.notify_at,
                                               job_id: event.notification_job_id)

      event.update(notification_job_id: result.value)
    end

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
