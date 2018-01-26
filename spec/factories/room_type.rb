# frozen_string_literal: true

FactoryGirl.define do
  factory :room_type do
    name 'Dummy Room Type'
    guards true

    trait :out_of_town do
      guards false
    end
  end
end
