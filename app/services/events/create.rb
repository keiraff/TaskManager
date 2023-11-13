# frozen_string_literal: true

module Events
  class Create < ApplicationService
    attr_reader :user, :params

    def initialize(user, params = {})
      @user = user
      @params = params
    end

    def call
      self.value = event_with_assigned_attributes

      if event.save
        schedule_email_notification if event.notify_at.present?

        success(event)
      else
        failure(event.errors.full_messages)
      end
    end

    private

    def event
      @event ||= user.events.new(params)
    end

    def schedule_email_notification
      event.update(notification_job_id: SendNotificationJob.perform_at(event.notify_at, event.id, user.id))
    end

    def utc_time_from_user_zone(user_time)
      return if user_time.blank?

      ActiveSupport::TimeZone.new(user.time_zone).local_to_utc(user_time)
    end

    def event_with_assigned_attributes
      event.assign_attributes(
        starts_at: utc_time_from_user_zone(event.starts_at),
        ends_at: utc_time_from_user_zone(event.ends_at),
        notify_at: utc_time_from_user_zone(event.notify_at)
      )

      event
    end
  end
end
