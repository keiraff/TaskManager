# frozen_string_literal: true

class AddNotificationJobIdToEvents < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :events, bulk: true do |t|
        t.string :notification_job_id
      end
    end
  end
end
