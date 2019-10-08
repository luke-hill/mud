# This has now been sanitized and simplified a bit, ignore the versions for now. They will be removed at a later date!

# V1.0 Minor Content Update and modifying of room types
Room.find_by(id: 3).update(room_type: 'Shop')
Room.find_by(id: 12).update(location: 'Forest Path - Clearing', hide_east: true)
Room.find_by(id: 19).update(east_key: 'Barracks Key')

Room.find_by(id: 5).update(
  description: 'There is a guard here who looks you up and down. You can leave freely for the Forest Path, or turn back to Newtown to the South.',
  location: 'Newtown - Gatehouse'
)

(10..20).to_a.each do |id_number|
  Room.find_by(id: id_number).update(room_type: 'Outside')
end

# V1.1 Forest Path Rooms
(35..49).to_a.each do |id_number|
  Room.create(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits.',
    advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown.',
    location: 'Forest Path',
    room_type: 'Outside',
    )
end

(51..57).to_a.each do |id_number|
  Room.create(
    id: id_number,
    description: 'This secluded area is notorious for being prime looting territory for local Bandits. You notice a lot of large structures to the North, that seems to form a large town or city.',
    advanced_description: 'The path seems to be covered in less Aurel Bark than earlier. Indicating that this path is perhaps used more. You can also hear what sounds like villagers, most likely from the neighbouring Sovereign City.',
    location: 'Forest Path',
    room_type: 'Outside',
    )
end

[50, 58].each do |id_number|
  Room.create(
    id: id_number,
    description: "This secluded area is notorious for being prime looting territory for local Bandits. You've happened on one of the inevitable dead-ends. Usually used to ambush travellers, you prepare for the worst.",
    advanced_description: 'This area seems to be covered in rags, as if the Bandits wanted to keep the path clean, to lure even more un-suspecting travellers into it.',
    location: 'Forest Path - Dead End',
    room_type: 'Outside',
    )
end

Room.create(
  id: 59,
  description: 'The guards at this gatehouse protect this city well, judging by how pristine everything looks. The city has an air of arrogance about it and the Guards do nothing to quell that, dressed in the finest Steel Chainmail.',
  advanced_description: 'Looking ahead you can make out the Council Square, where most of the Cities business is ran from. There are no signs directing you anywhere, almost as if everyone in the city knows where everything is.',
  location: 'Sovereign City - Gatehouse',
  )

# V1.1 Newtown Arena Rooms
Room.create(
  id: 60,
  description: "You see 3 separate small patches of ground, each monitored closely by a burly guard. He reminds you to read the sign before continuing if you're not sure.",
  advanced_description: 'You notice a sign that says North: Goblin Training Arena, West: Wolf Training Arena, South: Under Construction.',
  location: 'Newtown - Training Area'
)

(61..63).to_a.each do |id_number|
  Room.create(
    id: id_number,
    description: 'This Basic Arena is designed to get novice combatants ready to leave Newtown.',
    advanced_description: 'A Guard is in the corner, just in case things get out of hand. You see a Portcullis which can release monsters one at a time.',
    location: 'Newtown - Training Arena'
  )
end

# V1.1 Default Enemies in DB
(13..19).to_a.each do |id_number|
  Room.find_by(id: id_number).update(enemies: 'Goblin')
end

Room.find_by(id: 20).update(enemies: 'Orc')

[35, 36, 40, 42, 50, 52, 53, 54, 58].to_a.each do |id_number|
  Room.find_by(id: id_number).update(enemies: 'Bandit')
end

Room.find_by(id: 44).update(enemies: 'Wolf')

# V1.1 Change Pub's to type pub
Room.find_by(id: 1).update(room_type: 'Pub')

puts "#{Room.count} Rooms created in #{(Time.now - start).round(2)}s"
