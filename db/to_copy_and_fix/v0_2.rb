#V0.2 Locations
(1..9).to_a.each do |id_number|
  Room.find_by(id: id_number).update(location: 'Newtown')
end

[10, 11, 12].each do |id_number|
  Room.find_by(id: id_number).update(location: 'Forest Path')
end

(13..20).to_a.each do |id_number|
  Room.find_by(id: id_number).update(location: 'Barracks')
end

#V0.2 Newtown Residential District
[21, 22, 24, 25, 27].each do |id_number|
  Room.create(
    id: id_number,
    description: 'The rocky street here looks unfinished, you notice a cable on the floor next to the main road.',
    advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District lingers unfinished, with equipment strewn everywhere.',
    location: 'Newtown - Residential District'
  )
end

Room.create(
  id: 23,
  description: 'The rocky street here looks unfinished, you notice a cable on the floor next to the main road. There is a well to the east, next to a Small Bank for the Villagers.',
  advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District lingers unfinished. The sign for the bank looks rusty and dated as it flaps about in the wind.',
  location: 'Newtown - Residential District'
)

[26, 28].each do |id_number|
  Room.create(
    id: id_number,
    description: 'The rocky street here looks unfinished, you see signs that this used to be regular hive of activity.',
    advanced_description: "This area of the Newtown Residential District houses office buildings and even a long disbanded children's playground. Not that any parent would want their child playing next to the machinery!",
    location: 'Newtown - Residential District Crossroads'
  )
end

(29..33).each do |id_number|
  Room.create(
    id: id_number,
    description: 'One of the few remaining houses in Newtown. The interior looks basic, befitting a town of little to no wealth.',
    advanced_description: 'Whilst Pristine in condition, this house shows no sign of materialistic wealth.',
    location: 'Newtown - House'
  )
end

Room.create(
  id: 34,
  description: 'The Newtown bank is served by a single Teller. He sits behind the bars guarding a small storage room, presumably the sole vault on the premises.',
  advanced_description: "As you'd expect from a small bank, there is little extravagance... or security. Posters lie on the walls offering rewards for information on the whereabouts of the local Bandits that are hiding out.",
  location: 'Newtown - Bank'
)

#V0.2 Newtown Residential District - Directions and Connection from Room 2
Room.find_by(id: 2).update(south: 21, description: "The streets of Newtown are fairly quiet, as you'd expect from this remote area. You notice a side-path that leads to what looks like a Residential Area.")
Room.find_by(id: 21).update(north: 2, south: 22)
Room.find_by(id: 22).update(north: 21, south: 23)
Room.find_by(id: 23).update(north: 22, south: 24, east: 34)
Room.find_by(id: 24).update(north: 23, south: 25)
Room.find_by(id: 25).update(north: 24, south: 26)
Room.find_by(id: 26).update(north: 25, south: 27, east: 32, west: 33)
Room.find_by(id: 27).update(north: 26, south: 28)
Room.find_by(id: 28).update(north: 27, south: 29, east: 30, west: 31)
Room.find_by(id: 29).update(north: 28)
Room.find_by(id: 30).update(west: 28)
Room.find_by(id: 31).update(east: 28)
Room.find_by(id: 32).update(west: 26)
Room.find_by(id: 33).update(east: 26)
Room.find_by(id: 34).update(west: 23)
