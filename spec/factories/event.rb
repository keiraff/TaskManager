# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
    description { FFaker::Lorem.sentences }
    all_day { true }
    starts_at { FFaker::Time.datetime }
    notify_at { FFaker::Time.datetime }

    trait :not_all_day_event do
      all_day { false }
      ends_at { FFaker::Time.between(starts_at, starts_at + 2.days) }
    end
  end
end
