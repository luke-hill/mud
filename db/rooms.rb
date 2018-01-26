start = Time.now
puts 'Creating Rooms'

# This has now been sanitized and simplified a bit, ignore the versions for now. They will be removed at a later date!

no_enemy = Enemy.find_by_name('No Enemy')
town = RoomType.find_by_name('Town')
newtown = Location.find_by_area('Town Square')
barracks = Location.find_by_area('Barracks')
forest_path = Location.find_by_area('Forest Path')
residential_district = Location.find_by(town: 'Newtown', area: 'Residential District')
residential_crossroads = Location.find_by(town: 'Newtown', area: 'Residential District Crossroads')
newtown_house = Location.find_by(town: 'Newtown', area: 'House')
newtown_bank = Location.find_by(town: 'Newtown', area: 'Bank')

# V0.1 - 20 Blank Rooms
(1..20).to_a.each do |id_number|
  Room.create(
    room_id: id_number, description: 'DescriptionBLAHBLAHBLAHBLAH', advanced_description: 'Advanced DescriptionBLAHBLAHBLAHBLAH',
    room_type: town, location: newtown, enemy: no_enemy,
  )
end

#V0.1.1 Regular/Advanced Descriptions
Room.find_by(room_id: 1).update(
  description: 'The home of many of the men of the village of Newtown. The Newtown Pub offers its patrons a chance to sitdown, relax and rest your weary bones.',
  advanced_description: "The Fire is roaring, you hear chatter from the local villagers (What few reside here), about exploits in the neighbouring villages. The Barkeep begins to give you an angry look, then he asks you to leave as you're not spending Gold!",
  room_type: RoomType.find_by_name('Pub'),
)

[2, 4, 6, 7, 8, 9].each do |id_number|
  Room.find_by(room_id: id_number).update(
    description: "The streets of Newtown are fairly quiet, as you'd expect from this remote area.",
    advanced_description: "Cobbled with primitive cut stone, and put together many years ago, these streets look like they've seen better times. The signs for the once active market scene are now worn, you can vaguely make out a sign for \"Draz'ghun\" the Potion Salesman.",
  )
end

Room.find_by(room_id: 2).update(
  description: "The streets of Newtown are fairly quiet, as you'd expect from this remote area. You notice a side-path that leads to what looks like a Residential Area.",
)

Room.find_by(room_id: 3).update(
  description: "Draz'ghun's Shop. Whilst small in nature, the vendor here can offer a small selection of potions from Draz'ghuns famed brewing.",
  advanced_description: "You look around and ask the Vendor for the Owner, who simply remarks that he's away on his adventures. The bottles on the shelves seem dirty, but you're told that the look is purely designed that way... To appeal to Travellers.",
  room_type: RoomType.find_by_name('Potion Shop'),
)

Room.find_by(room_id: 5).update(
  description: 'Gatehouse. The guard looks you up and down as you leave for the Forest Path.',
  advanced_description: 'Looking ahead, you can see the Forest Path out ahead, covered in a thin trail of leaves from the Trees that have been cut down for their Aurel Bark.',
)

[10, 11].each do |id_number|
  Room.find_by(room_id: id_number).update(
    description: 'This secluded area is notorious for being prime looting territory for local Bandits.',
    advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown.',
    room_type: RoomType.find_by_name('Out of Town'),
    location: forest_path,
  )
end

Room.find_by(room_id: 12).update(
  description: 'This clearing appears to be some sort of crossroads, the sign you can barely make out. You can see to your West that there is a long and windy path, which looks worn.',
  advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown. You attempt to read the worn sign, but can only see at the bottom that there is mention of a Reward?',
  room_type: RoomType.find_by_name('Out of Town'),
  location: forest_path,
)

Room.find_by(room_id: 13).update(
  description: "The Barracks are dimly lit and the room you're in is very cold.",
  advanced_description: "As you look around, you see the light casting a shadow down the tunnel from the path you've just descended. The walls have various weapons hung up, all are broken beyond use.",
  room_type: RoomType.find_by_name('Dungeon'),
  location: barracks,
)

(14..18).to_a.each do |id_number|
  Room.find_by(room_id: id_number).update(
    description: "The Barracks are dimly lit and the room you're in is very cold.",
    advanced_description: "Looking around, you can tell that no traveller has ventured into these abandoned Barracks for a long time. There are some stains on the walls, but they're too dark to be blood, it almost looks inhuman.",
    room_type: RoomType.find_by_name('Dungeon'),
    location: barracks,
    ktp: true,
  )
end

Room.find_by(room_id: 19).update(
  description: "The Barracks are dimly lit and the room you're in is very cold... But you can feel some heat radiating from the door.",
  advanced_description: 'You notice that the style of the area is all the same, except for the fact there is a door to the east, what looks like some sort of Office. The door is locked and has not been opened in some time, judging by the rust build-up.',
  room_type: RoomType.find_by_name('Dungeon'),
  location: barracks,
  ktp: true,
)

Room.find_by(room_id: 20).update(
  description: 'The room is covered in blood, stained from the battles of past. There is a worn stool in the corner, where it looks as if the Barracks Master has been sitting.',
  advanced_description: "You've heard the stories since you were a child about some sort of Monster guarding the treasure, and now you know it's true. In the corner is a rudimentary smithing forge that looks ancient, with some leftover bits almost beyond salvage.",
  room_type: RoomType.find_by_name('Dungeon'),
  location: barracks,
  ktp: true,
)

# V0.2 Newtown Residential District
[21, 22, 24, 25, 27].each do |id_number|
  Room.create(
    room_id: id_number,
    description: 'The rocky street here looks unfinished, you notice a cable on the floor next to the main road.',
    advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District lingers unfinished, with equipment strewn everywhere.',
    location: residential_district, room_type: town, enemy: no_enemy,
  )
end

Room.create(
  room_id: 23,
  description: 'The rocky street here looks unfinished, you notice a cable on the floor next to the main road. There is a well to the east, next to a Small Bank for the Villagers.',
  advanced_description: 'Once destined to be the worlds first eco-friendly housing estate, The Newtown Residential District lingers unfinished. The sign for the bank looks rusty and dated as it flaps about in the wind.',
  location: residential_district, room_type: town, enemy: no_enemy,
)

[26, 28].each do |id_number|
  Room.create(
    room_id: id_number,
    description: 'The rocky street here looks unfinished, you see signs that this used to be regular hive of activity.',
    advanced_description: "This area of the Newtown Residential District houses office buildings and even a long disbanded children's playground. Not that any parent would want their child playing next to the machinery!",
    location: residential_crossroads, room_type: town, enemy: no_enemy,
  )
end

(29..33).each do |id_number|
  Room.create(
    room_id: id_number,
    description: 'One of the few remaining houses in Newtown. The interior looks basic, befitting a town of little to no wealth.',
    advanced_description: 'Whilst Pristine in condition, this house shows no sign of materialistic wealth.',
    location: newtown_house, room_type: town, enemy: no_enemy,
  )
end

Room.create(
  room_id: 34,
  description: 'The Newtown bank is served by a single Teller. He sits behind the bars guarding a small storage room, presumably the sole vault on the premises.',
  advanced_description: "As you'd expect from a small bank, there is little extravagance... or security. Posters lie on the walls offering rewards for information on the whereabouts of the local Bandits that are hiding out.",
  location: newtown_bank, room_type: town, enemy: no_enemy,
)

# V0.1 - V0.2 Newtown Directions
Room.find_by(room_id: 1).update(north: 9, east: 2, west: 8)
Room.find_by(room_id: 2).update(north: 3, south: 21, west: 1)
Room.find_by(room_id: 3).update(north: 4, south: 2, west: 9)
Room.find_by(room_id: 4).update(south: 3, west: 5)
Room.find_by(room_id: 5).update(north: 10, south: 9, east: 4, west: 6)
Room.find_by(room_id: 6).update(south: 7, east: 5)
Room.find_by(room_id: 7).update(north: 6, south: 8, east: 9)
Room.find_by(room_id: 8).update(north: 7, east: 1)
Room.find_by(room_id: 9).update(north: 5, south: 1, east: 3, west: 7)
Room.find_by(room_id: 10).update(north: 11, south: 5)
Room.find_by(room_id: 11).update(north: 12, south: 10)
Room.find_by(room_id: 12).update(south: 11, east: 13)
Room.find_by(room_id: 13).update(east: 14, west: 12)
Room.find_by(room_id: 14).update(east: 15, west: 13)
Room.find_by(room_id: 15).update(east: 16, west: 14)
Room.find_by(room_id: 16).update(east: 17, west: 15)
Room.find_by(room_id: 17).update(east: 18, west: 16)
Room.find_by(room_id: 18).update(east: 19, west: 17)
Room.find_by(room_id: 19).update(east: 20, west: 18)
Room.find_by(room_id: 20).update(west: 19)
Room.find_by(room_id: 21).update(north: 2, south: 22)
Room.find_by(room_id: 22).update(north: 21, south: 23)
Room.find_by(room_id: 23).update(north: 22, south: 24, east: 34)
Room.find_by(room_id: 24).update(north: 23, south: 25)
Room.find_by(room_id: 25).update(north: 24, south: 26)
Room.find_by(room_id: 26).update(north: 25, south: 27, east: 32, west: 33)
Room.find_by(room_id: 27).update(north: 26, south: 28)
Room.find_by(room_id: 28).update(north: 27, south: 29, east: 30, west: 31)
Room.find_by(room_id: 29).update(north: 28)
Room.find_by(room_id: 30).update(west: 28)
Room.find_by(room_id: 31).update(east: 28)
Room.find_by(room_id: 32).update(west: 26)
Room.find_by(room_id: 33).update(east: 26)
Room.find_by(room_id: 34).update(west: 23)

puts "#{Room.count} Rooms created in #{(Time.now - start).round(2)}s"
