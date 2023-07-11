# frozen_string_literal: true

# V1.1 (large content update)
# Forest Path - Descriptions and Basic Enemies
# Newtown Arena/Pub - Descriptions
# Barracks - Basic / Boss Enemies

ap = AdminPanel::Seeder.new(:description)

(35..49).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits.',
    advanced_description: 'The path is covered in a thin layer of leaves and shavings of ' \
                          'Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown.',
    location_id: 'forest_path',
    type: 'Outside'
  )
end

(51..57).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits. You notice a lot ' \
                 'of large structures to the North, that seems to form a large town or city.',
    advanced_description: 'The path seems to be covered in less Aurel Bark than earlier. Indicating that this path is perhaps used more. ' \
                          'You can also hear what sounds like villagers, most likely from the neighbouring Sovereign City.',
    location_id: 'forest_path',
    type: 'Outside'
  )
end

[50, 58].each do |id_number|
  ap.seed(
    id: id_number,
    description: "This secluded area is notorious for being prime looting territory for local Bandits. You've happened on one of " \
                 "the inevitable dead-ends. Usually used to ambush travellers, you prepare for the worst.",
    advanced_description: 'This area seems to be covered in rags, as if the Bandits wanted ' \
                          'to keep the path clean, to lure even more un-suspecting travellers into it.',
    location_id: 'forest_path',
    type: 'Outside'
  )
end

ap.seed(
  id: 59,
  description: 'The guards at this gatehouse protect this city well, judging by how pristine everything looks. The city has an air of ' \
               'arrogance about it and the Guards do nothing to quell that, dressed in the finest Steel Chainmail.',
  advanced_description: 'Looking ahead you can make out the Council Square, where most of the business of Sovereign City is ran from. ' \
                        'There are no signs directing you anywhere, almost as if everyone in the city knows where everything is.',
  location_id: 'sovereign_city_gatehouse',
  type: 'Town'
)

ap.seed(
  id: 60,
  description: 'You see 3 separate small patches of ground, each monitored closely by a ' \
               "burly guard. He reminds you to read the sign before continuing if you're not sure.",
  advanced_description: 'You notice a sign that says North: Goblin Training Arena, West: Brawler Training Arena, ' \
                        'South: Under Construction.',
  location_id: 'newtown_training_area',
  type: 'Town'
)

(61..63).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This Basic Arena is designed to get novice combatants ready to leave Newtown.',
    advanced_description: 'A Guard is in the corner, just in case things get out of hand. You see a Portcullis ' \
                          'which can release various adversaries one at a time.',
    location_id: 'newtown_training_area',
    type: 'Arena'
  )
end

ap.seed(id: 1, type: 'Pub')

(13..19).each do |id_number|
  ap.seed(id: id_number, enemy_id: 'goblin')
end

ap.seed(id: 20, enemy_id: 'orc')

[35, 36, 40, 42, 50, 52, 53, 54, 58].each do |id_number|
  ap.seed(id: id_number, enemy_id: 'bandit')
end

ap.seed(id: 44, enemy_id: 'wolf')
