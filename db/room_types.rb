start = Time.now
puts 'Creating Room Types'

Room.create(name: 'Town')
Room.create(name: 'Weapon Shop')
Room.create(name: 'Armor Shop')
Room.create(name: 'Potion Shop')
Room.create(name: 'Arena')
Room.create(name: 'Pub')
Room.create(name: 'Basic Training Guild')
Room.create(name: 'Training Guild')
Room.create(name: 'Gatehouse')
Room.create(name: 'Out of Town')
Room.create(name: 'Dungeon')
Room.create(name: 'Underground')

puts "Room Types created in #{(Time.now - start).round(2)}s"
