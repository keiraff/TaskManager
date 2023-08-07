# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  all_day     :boolean          not null
#  description :text
#  ends_at     :datetime
#  name        :text             not null
#  notify_at   :datetime
#  starts_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_events_on_user_id                  (user_id)
#  index_events_on_user_id_and_category_id  (user_id,category_id)
#  index_events_on_user_id_and_name         (user_id,name)
#  index_events_on_user_id_and_starts_at    (user_id,starts_at)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true
  validates :all_day, inclusion: { in: [true, false] }
  validates :starts_at, presence: true,
                        comparison: {
                          greater_than_or_equal_to: Time.current, message: "must be greater or equal to current time"
                        }
  validates :ends_at, presence: true, unless: :all_day?,
                      comparison: { greater_than: :starts_at, message: "must be greater than starts at" }
  validates :ends_at, absence: true, if: :all_day?

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "starts_at", "name", "category_id"]
  end
end
