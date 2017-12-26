# frozen_string_literal: true

FactoryGirl.define do
  factory :room do
    sequence(:room_id)

    trait :in_town do
      room_type 1
      location 1
      guards true
      ktp false
      default_enemy 1
    end

    trait :out_of_town do
      room_type 2
      location 2
      guards false
      ktp true
      default_enemy 2
    end

    description 'This is a Test Description'
    advanced_description 'Test Advanced Description'
  end
end
