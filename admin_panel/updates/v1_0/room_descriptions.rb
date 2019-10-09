# V1.0 Minor Content Update and modifying of room types

ap = AdminPanel::Room::Descriptions

# TODO: Add this code into the room presenter logic when we get there!
ap.seed(id: 12, hide_east: true)
ap.seed(id: 19, east_key: 'barracks_key')

ap.seed(
  id: 5,
  description: 'There is a guard here who looks you up and down. You can leave freely for the Forest Path, or turn back to Newtown to the South.',
  location: 'newtown_gatehouse'
)

(10..20).each do |id_number|
  ap.seed(id: id_number, type: 'Outside')
end
