# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: false

      t.text :name, null: false
      t.boolean :all_day, null: false
      t.timestamp :starts_at, null: false
      t.timestamp :ends_at
      t.text :description
      t.timestamp :notify_at

      t.index [:user_id, :name]
      t.index [:user_id, :category_id]
      t.index [:user_id, :starts_at]

      t.timestamps
    end
  end
end
