# V0.1 - 20 Blank Rooms

ap = AdminPanel::Room::Base.new(:descriptions)

(1..20).to_a.each do |id_number|
  ap.seed(
    id: id_number,
    description: 'DescriptionBLAHBLAHBLAHBLAH',
    advanced_description: 'Advanced DescriptionBLAHBLAHBLAHBLAH',
    type: 'town',
    location: 'newtown_town_square',
    enemy: 'no_enemy'
  )
end
