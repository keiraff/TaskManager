# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  date         :datetime         not null
#  description  :string
#  name         :string           not null
#  notification :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_events_on_user_id                  (user_id)
#  index_events_on_user_id_and_category_id  (user_id,category_id)
#  index_events_on_user_id_and_date         (user_id,date)
#  index_events_on_user_id_and_name         (user_id,name)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :date, presence: true, comparison: { greater_than_or_equal_to: Time.current }
end
