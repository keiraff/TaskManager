# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    enable_extension "citext"

    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.citext :name, null: false

      t.index  [:user_id, :name], unique: true

      t.timestamps
    end
  end
end
