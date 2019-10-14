# V0.1.1 Regular / Advanced Descriptions

ap = AdminPanel::Base.new(:descriptions)

ap.seed(id: 1).update(
  description: 'The home of many of the men of the village of Newtown. The Newtown Pub offers its patrons a chance to sitdown, relax and rest your weary bones.',
  advanced_description: "The Fire is roaring, you hear chatter from the local villagers (What few reside here), about exploits in the neighbouring villages. The Barkeep begins to give you an angry look, then he asks you to leave as you're not spending Gold!",
  type: 'Pub'
)

[2, 4, 6, 7, 8, 9].each do |id_number|
  ap.seed(id: id_number).update(
    description: "The streets of Newtown are fairly quiet, as you'd expect from this remote area.",
    advanced_description: "Cobbled with primitive cut stone, and put together many years ago, these streets look like they've seen better times. The signs for the once active market scene are now worn, you can vaguely make out a sign for \"Draz'ghun\" the Potion Salesman."
  )
end

ap.seed(id: 2).update(
  description: "The streets of Newtown are fairly quiet, as you'd expect from this remote area. You notice a side-path that leads to what looks like a Residential Area."
)

ap.seed(id: 3).update(
  description: "Draz'ghun's Shop. Whilst small in nature, the vendor here can offer a small selection of potions from Draz'ghuns famed brewing.",
  advanced_description: "You look around and ask the Vendor for the Owner, who simply remarks that he's away on his adventures. The bottles on the shelves seem dirty, but you're told that the look is purely designed that way... To appeal to Travellers.",
  type: 'Potion Shop'
)

ap.seed(id: 5).update(
  description: 'Gatehouse. The guard looks you up and down as you leave for the Forest Path.',
  advanced_description: 'Looking ahead, you can see the Forest Path out ahead, covered in a thin trail of leaves from the Trees that have been cut down for their Aurel Bark.'
)

[10, 11].each do |id_number|
  ap.seed(id: id_number).update(
    description: 'This secluded area is notorious for being prime looting territory for local Bandits.',
    advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown.',
    type: 'Out of Town',
    location: 'forest_path'
  )
end

ap.seed(id: 12).update(
  description: 'This clearing appears to be some sort of crossroads, the sign you can barely make out. You can see to your West that there is a long and windy path, which looks worn.',
  advanced_description: 'The path is covered in a thin layer of leaves and shavings of Aurel Bark, an oft harvested ingredient by workers that used to be sold in Newtown. You attempt to read the worn sign, but can only see at the bottom that there is mention of a Reward?',
  type: 'Out of Town',
  location: 'forest_path'
)

ap.seed(id: 13).update(
  description: "The Barracks are dimly lit and the room you're in is very cold.",
  advanced_description: "As you look around, you see the light casting a shadow down the tunnel from the path you've just descended. The walls have various weapons hung up, all are broken beyond use.",
  type: 'Dungeon',
  location: 'barracks'
)

(14..18).to_a.each do |id_number|
  ap.seed(id: id_number).update(
    description: "The Barracks are dimly lit and the room you're in is very cold.",
    advanced_description: "Looking around, you can tell that no traveller has ventured into these abandoned Barracks for a long time. There are some stains on the walls, but they're too dark to be blood, it almost looks inhuman.",
    type: 'Dungeon',
    location: 'barracks',
    ktp: true
  )
end

ap.seed(id: 19).update(
  description: "The Barracks are dimly lit and the room you're in is very cold... But you can feel some heat radiating from the door.",
  advanced_description: 'You notice that the style of the area is all the same, except for the fact there is a door to the east, what looks like some sort of Office. The door is locked and has not been opened in some time, judging by the rust build-up.',
  type: 'Dungeon',
  location: 'barracks',
  ktp: true
)

ap.seed(id: 20).update(
  description: 'The room is covered in blood, stained from the battles of past. There is a worn stool in the corner, where it looks as if the Barracks Master has been sitting.',
  advanced_description: "You've heard the stories since you were a child about some sort of Monster guarding the treasure, and now you know it's true. In the corner is a rudimentary smithing forge that looks ancient, with some leftover bits almost beyond salvage.",
  type: 'Dungeon',
  location: 'barracks',
  ktp: true
)
