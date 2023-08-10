# frozen_string_literal: true

class AddLocationToUser < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :users, bulk: true do |t|
        t.string :country
        t.string :state
        t.string :city
      end
    end
  end
end
