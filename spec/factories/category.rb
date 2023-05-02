# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    association :user
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
