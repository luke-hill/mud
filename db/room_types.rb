start = Time.now
puts 'Creating RoomType Types'

RoomType.create(name: 'Town')
RoomType.create(name: 'Weapon Shop')
RoomType.create(name: 'Armor Shop')
RoomType.create(name: 'Potion Shop')
RoomType.create(name: 'Arena')
RoomType.create(name: 'Pub')
RoomType.create(name: 'Basic Training Guild')
RoomType.create(name: 'Training Guild')
RoomType.create(name: 'Gatehouse')
RoomType.create(name: 'Out of Town')
RoomType.create(name: 'Dungeon')
RoomType.create(name: 'Underground')

puts "RoomType Types created in #{(Time.now - start).round(2)}s"
