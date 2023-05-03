# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }

    trait :with_user do
      association :user
    end
  end
end
