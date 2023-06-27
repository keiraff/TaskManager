# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :citext           not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :categories, dependent: :restrict_with_exception
  has_many :events, dependent: :restrict_with_exception

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\A.+@.+\..+\z/
  validates :password, confirmation: true, length: { minimum: 6 }
end
