start = Time.now
puts 'Creating RoomTypes'

# room type wasn't present until much later on especially with guards param (probably v1)
RoomType.create(name: 'Town')
RoomType.create(name: 'Weapon Shop')
RoomType.create(name: 'Armor Shop')
RoomType.create(name: 'Potion Shop')
RoomType.create(name: 'Arena', guards: false)
RoomType.create(name: 'Pub')
RoomType.create(name: 'Basic Training Guild')
RoomType.create(name: 'Training Guild')
RoomType.create(name: 'Out of Town', guards: false)
RoomType.create(name: 'Dungeon', guards: false)
RoomType.create(name: 'Underground', guards: false)

puts "#{RoomType.count} RoomTypes created in #{(Time.now - start).round(2)}s"
