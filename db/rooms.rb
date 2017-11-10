start = Time.now
puts 'Creating Rooms'

1.upto(25) do |n|
  north = n + 5 if n <= 20
  south = n - 5 if n > 5
  east = n + 1 if n % 5 != 0
  west = n - 1 if n % 5 != 1

  Room.create(
    room_id: n, north: north, south: south, east: east, west: west, room_type: 1,
    location: 1, guards: true, ktp: false, default_enemy: 1,
    description: "Room #{n.humanize}", advanced_description: "Advanced - Room #{n.humanize}"
  )
end

puts "Rooms created in #{(Time.now - start).round(2)}s"
