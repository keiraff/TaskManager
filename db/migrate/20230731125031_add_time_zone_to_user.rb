# frozen_string_literal: true

class AddTimeZoneToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :time_zone, :string, null: false, default: "UTC"
  end
end
