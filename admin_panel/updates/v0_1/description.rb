# frozen_string_literal: true

# V0.1 - 20 Blank Rooms

ap = AdminPanel::Seeder.new(:description)

(1..20).to_a.each do |id_number|
  ap.seed(
    id: id_number,
    description: 'DescriptionBLAHBLAHBLAHBLAH',
    advanced_description: 'Advanced DescriptionBLAHBLAHBLAHBLAH',
    type: 'Town',
    location_id: 'newtown_town_square',
    enemy_id: 'no_enemy'
  )
end
