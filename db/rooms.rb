start = Time.now
puts 'Creating Rooms'

# This has now been sanitized and simplified a bit
require_relative 'legacy_room_data'

Room.all.each do |room|
  room.update(ktp: false)
end

puts "#{Room.count} Rooms created in #{(Time.now - start).round(2)}s"
