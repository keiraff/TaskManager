# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: false

      t.text :name, null: false
      t.timestamp :scheduled_at, null: false
      t.text :description
      t.timestamp :notification

      t.index [:user_id, :name]
      t.index [:user_id, :category_id]
      t.index [:user_id, :scheduled_at]

      t.timestamps
    end
  end
end
