# frozen_string_literal: true

# V0.2 Newtown Residential District

ap = AdminPanel::Seeder.new(:description)

[21, 22, 24, 25, 27].each do |id_number|
  ap.seed(
    id: id_number,
    description: 'The rocky street here looks unfinished, you notice a cable on the floor next to the main road.',
    advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District ' \
                          'lingers unfinished, with construction equipment strewn everywhere.',
    location_id: 'newtown_residential_district',
    type: 'Town',
    enemy_id: 'no_enemy'
  )
end

ap.seed(
  id: 23,
  description: 'The rocky street here looks unfinished, you notice a cable on the floor next to ' \
               'the main road. There is a well to the east, next to a Small Bank for the Villagers.',
  advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District ' \
                        'lingers unfinished. The sign for the bank looks rusty and dated as it flaps about in the wind.',
  location_id: 'newtown_residential_district',
  type: 'Town',
  enemy_id: 'no_enemy'
)

[26, 28].each do |id_number|
  ap.seed(
    id: id_number,
    description: 'The rocky street here looks unfinished, you see signs that this used to be a regular hive of activity.',
    advanced_description: 'This area of the Newtown Residential District houses office buildings and even a long disbanded' \
                          "children's playground. Not that any parent would want their child playing next to the machinery!",
    location_id: 'newtown_residential_district_crossroads',
    type: 'Town',
    enemy_id: 'no_enemy'
  )
end

(29..33).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'One of the few remaining houses in Newtown. The interior looks basic, befitting a town of little to no wealth.',
    advanced_description: 'Whilst Pristine in condition, this house shows no sign of materialistic wealth.',
    location_id: 'newtown_house',
    type: 'Town',
    enemy_id: 'no_enemy'
  )
end

ap.seed(
  id: 34,
  description: 'The Newtown bank is served by a single Teller. He sits behind the bars guarding ' \
               'a small storage room, presumably the sole vault on the premises.',
  advanced_description: "As you'd expect from a small bank, there is little extravagance... " \
                        'or security it seems. Posters lie on the walls offering rewards for information on the ' \
                        'whereabouts of the local Bandits that are hiding out and stealing from the patrons of the Bank.',
  location_id: 'newtown_bank',
  type: 'Town',
  enemy_id: 'no_enemy'
)
