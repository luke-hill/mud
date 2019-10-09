# V1.1 (large content update)
# Forest Path - Descriptions and Basic Enemies
# Newtown Arena/Pub - Descriptions
# Barracks - Basic / Boss Enemies

ap = AdminPanel::Room::Descriptions

(35..49).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits.',
    advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown.',
    location: 'forest_path',
    type: 'Outside'
  )
end

(51..57).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits. You notice a lot of large structures to the North, that seems to form a large town or city.',
    advanced_description: 'The path seems to be covered in less Aurel Bark than earlier. Indicating that this path is perhaps used more. You can also hear what sounds like villagers, most likely from the neighbouring Sovereign City.',
    location: 'forest_path',
    type: 'Outside'
  )
end

[50, 58].each do |id_number|
  ap.seed(
    id: id_number,
    description: "This secluded area is notorious for being prime looting territory for local Bandits. You've happened on one of the inevitable dead-ends. Usually used to ambush travellers, you prepare for the worst.",
    advanced_description: 'This area seems to be covered in rags, as if the Bandits wanted to keep the path clean, to lure even more un-suspecting travellers into it.',
    location: 'forest_path',
    room_type: 'Outside'
  )
end

# TODO: This previously had
# location: 'Sovereign City - Gatehouse'
# This isn't valid and will need fixing down the line in a v2 patch fix
ap.seed(
  id: 59,
  description: 'The guards at this gatehouse protect this city well, judging by how pristine everything looks. The city has an air of arrogance about it and the Guards do nothing to quell that, dressed in the finest Steel Chainmail.',
  advanced_description: 'Looking ahead you can make out the Council Square, where most of the Cities business is ran from. There are no signs directing you anywhere, almost as if everyone in the city knows where everything is.',
  location: 'forest_path',
)

ap.seed(
  description: "You see 3 separate small patches of ground, each monitored closely by a burly guard. He reminds you to read the sign before continuing if you're not sure.",
  advanced_description: 'You notice a sign that says North: Goblin Training Arena, West: Wolf Training Arena, South: Under Construction.',
  location: 'newtown_training_area'
)

(61..63).each do |id_number|
  ap.seed(
    id: id_number,
    description: 'This Basic Arena is designed to get novice combatants ready to leave Newtown.',
    advanced_description: 'A Guard is in the corner, just in case things get out of hand. You see a Portcullis which can release monsters one at a time.',
    location: 'newtown_training_area'
  )
end

ap.seed(id: 1, type: 'Pub')

(13..19).each do |id_number|
  ap.seed(id: id_number, enemy: 'goblin')
end

ap.seed(id: 20, enemy: 'orc')

# TODO: This enemy isn't seeded. Needs adding to v1.1 enemy seeds (Also need to remember data)
[35, 36, 40, 42, 50, 52, 53, 54, 58].each do |id_number|
  ap.seed(id: id_number, enemy: 'bandit')
end

# TODO: This enemy isn't seeded. Needs adding to v1.1 enemy seeds (Also need to remember data)
# This had bloody claws and wolf hide and was really tough (but still only 1 stam
# accuracy was poor but hp and dmg was high - idea was you had to kill him to get to sovereign city
ap.seed(id: 44, enemy: 'wolf')
