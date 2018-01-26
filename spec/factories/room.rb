# frozen_string_literal: true

FactoryGirl.define do
  factory :room do
    sequence(:room_id) { |n| n }
    description 'This is a Test Description'
    advanced_description 'Test Advanced Description'
    room_type
    location
    enemy
    ktp false

    trait :out_of_town do
      ktp true
    end
  end
end
