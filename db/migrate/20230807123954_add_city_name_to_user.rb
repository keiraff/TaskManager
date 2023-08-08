# frozen_string_literal: true

class AddCityNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :city_name, :string
  end
end
