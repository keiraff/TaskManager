# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
    description { FFaker::Lorem.sentence }
    all_day { true }
    starts_at { 1.day.from_now }

    trait :not_all_day do
      all_day { false }
      ends_at { FFaker::Time.between(starts_at, starts_at + 2.days) }
    end
  end
end
