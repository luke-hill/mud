start = Time.now
puts 'Creating RoomTypes'

RoomType.create(name: 'Town')
RoomType.create(name: 'Weapon Shop')
RoomType.create(name: 'Armor Shop')
RoomType.create(name: 'Potion Shop')
RoomType.create(name: 'Arena', guards: false)
RoomType.create(name: 'Pub')
RoomType.create(name: 'Basic Training Guild')
RoomType.create(name: 'Training Guild')
RoomType.create(name: 'Gatehouse')
RoomType.create(name: 'Out of Town', guards: false)
RoomType.create(name: 'Dungeon', guards: false)
RoomType.create(name: 'Underground', guards: false)

puts "#{RoomType.count} RoomTypes created in #{(Time.now - start).round(2)}s"
