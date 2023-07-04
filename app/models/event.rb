# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  description  :text
#  name         :text             not null
#  notification :datetime
#  scheduled_at :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_events_on_user_id                   (user_id)
#  index_events_on_user_id_and_category_id   (user_id,category_id)
#  index_events_on_user_id_and_name          (user_id,name)
#  index_events_on_user_id_and_scheduled_at  (user_id,scheduled_at)
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
  validates :scheduled_at, presence: true, comparison: { greater_than_or_equal_to: Time.current }
end
