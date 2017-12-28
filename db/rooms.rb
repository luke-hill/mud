start = Time.now
puts 'Creating Rooms'

goblin = Enemy.find_by_name('Goblin')

1.upto(25) do |n|
  north = n + 5 if n <= 20
  south = n - 5 if n > 5
  east = n + 1 if n % 5 != 0
  west = n - 1 if n % 5 != 1

  Room.create(
    room_id: n, north: north, south: south, east: east, west: west, room_type_id: 1,
    location_id: 1, guards: true, ktp: false,
    description: "Room #{n.humanize}", advanced_description: "Advanced - Room #{n.humanize}"
  )

  if n.even?
    Room.find_by_room_id(n).update(enemy_id: goblin.id)
  end
end

puts "Rooms created in #{(Time.now - start).round(2)}s"
