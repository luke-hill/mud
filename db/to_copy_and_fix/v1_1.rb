#V1.1 Forest Path Rooms
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

#V1.1 Forest Path Directions
Room.find_by(id: 12).update(west: 35)
Room.find_by(id: 35).update(east: 12, west: 36)
Room.find_by(id: 36).update(east: 35, west: 37)
Room.find_by(id: 37).update(east: 36, north: 38)
Room.find_by(id: 38).update(north: 39, south: 37)
Room.find_by(id: 39).update(east: 40, south: 38)
Room.find_by(id: 40).update(east: 41, west: 39)
Room.find_by(id: 41).update(east: 42, west: 40)
Room.find_by(id: 42).update(east: 43, west: 41)
Room.find_by(id: 43).update(east: 44, west: 42)
Room.find_by(id: 44).update(north: 51, east: 45, west: 43)
Room.find_by(id: 45).update(east: 46, west: 44)
Room.find_by(id: 46).update(north: 47, west: 45)
Room.find_by(id: 47).update(north: 48, south: 46)
Room.find_by(id: 48).update(east: 49, south: 47)
Room.find_by(id: 49).update(east: 50, west: 48)
Room.find_by(id: 50).update(west: 49)
Room.find_by(id: 51).update(north: 52, south: 44)
Room.find_by(id: 52).update(west: 53, south: 51)
Room.find_by(id: 53).update(east: 52, west: 54)
Room.find_by(id: 54).update(east: 53, west: 55)
Room.find_by(id: 55).update(north: 56, east: 54, west: 58)
Room.find_by(id: 56).update(north: 57, south: 55)
Room.find_by(id: 57).update(north: 59, south: 56)
Room.find_by(id: 58).update(east: 55)
Room.find_by(id: 59).update(south: 57)

#V1.1 Newtown Arena Rooms
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

#V1.1 Newtown Arena Directions
Room.find_by(id: 6).update(west: 60)
Room.find_by(id: 60).update(north: 61, south: 62, west: 63, east: 6)
Room.find_by(id: 61).update(south: 60)
Room.find_by(id: 62).update(north: 60)
Room.find_by(id: 63).update(east: 60)

#V1.1 Default Enemies in DB
(13..19).to_a.each do |id_number|
  Room.find_by(id: id_number).update(enemy: 'Goblin')
end

Room.find_by(id: 20).update(enemy: 'Orc')

[35, 36, 40, 42, 50, 52, 53, 54, 58].to_a.each do |id_number|
  Room.find_by(id: id_number).update(enemy: 'Bandit')
end

Room.find_by(id: 44).update(enemy: 'Wolf')

#V1.1 Change Pub's to type pub
Room.find_by(id: 1).update(room_type: 'Pub')
