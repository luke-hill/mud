FactoryGirl.define do
  factory :player, class: ActivePlayer do
    name 'Test Player'
    room
    room_id 1
  end
end
