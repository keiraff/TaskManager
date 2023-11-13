# frozen_string_literal: true

module EmailNotifications
  class Update < ApplicationService
    attr_reader :event_id, :user_id, :notify_at, :job_id

    def initialize(event_id:, user_id:, notify_at:, job_id:)
      @notify_at = notify_at
      @job_id = job_id
      @user_id = user_id
      @event_id = event_id
    end

    def call
      delete_previous_job if job_id.present?

      self.value = SendNotificationJob.perform_at(notify_at, event_id, user_id) if notify_at.present?

      success(value)
    end

    private

    def delete_previous_job
      job = Sidekiq::ScheduledSet.new.find_job(job_id)
      job.delete
    end
  end
end
