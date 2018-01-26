#V1.0 Minor Content Update and modifying of room types
Room.find_by(id: 3).update(room_type: 'Shop')
Room.find_by(id: 12).update(location: 'Forest Path - Clearing', hide_east: true)
Room.find_by(id: 19).update(east_key: 'Barracks Key')

Room.find_by(id: 5).update(
  description: 'There is a guard here who looks you up and down. You can leave freely for the Forest Path, or turn back to Newtown to the South.',
  location: 'Newtown - Gatehouse'
)

(10..20).to_a.each do |id_number|
  Room.find_by(id: id_number).update(room_type: 'Outside')
end
