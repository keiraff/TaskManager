# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
    description { FFaker::Lorem.sentences }
    scheduled_at { FFaker::Time.datetime }
    notification { FFaker::Time.datetime }
  end
end
