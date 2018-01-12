FactoryGirl.define do
  factory :enemy do
    name 'Test Enemy'
    description 'Wow, Here is a Test Enemy'
    weapon_id 1
    armor_id 1
    lower_hp_limit 5
    upper_hp_limit 10
    accuracy 0
    lower_gold_limit 5
    upper_gold_limit 10
    xp 1
    xp_killshot 10
    stamina 1

    trait :goblin do
      name 'Goblin'
      description 'Gobby Gobby Gobby Goblin'
    end

    trait :dead do
      lower_hp_limit 0
      upper_hp_limit 0
    end
  end
end
