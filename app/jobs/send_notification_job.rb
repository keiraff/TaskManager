# frozen_string_literal: true

class SendNotificationJob
  include Sidekiq::Job
  sidekiq_options queue: "default", retry: 0

  def perform(event_id, user_id)
    user = User.find(user_id)
    event = Event.find(event_id)

    NotificationMailer.event_notification(event, user).deliver_now

    event.update(notification_job_id: nil, notify_at: nil)
  end
end
