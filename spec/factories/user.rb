# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    sequence(:email) { |n| "#{first_name}#{n}@example.com" }
    password { FFaker::Internet.password }

    trait :with_categories do
      after(:build) do |user|
        user.categories = FactoryBot.build_list(:category, 2)
      end
    end
  end
end
