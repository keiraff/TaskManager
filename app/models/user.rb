# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string
#  password_digest :string           not null
#  surname         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  before_validation :downcase_email
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: /.+@.+\..+/
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
