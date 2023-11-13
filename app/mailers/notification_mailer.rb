# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: "notifications@example.com"

  def event_notification(event, user)
    @event = event
    @user = user
    mail(to: @user.email, subject: "You have #{@event.name} soon.")
  end
end
