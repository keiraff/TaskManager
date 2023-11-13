# frozen_string_literal: true

class AddNotificationJobIdToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :notification_job_id, :string
  end
end
