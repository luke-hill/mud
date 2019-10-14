# V1.1
# Room Presenter Logic (Hidden Rooms / Key Rooms)
# Forest Path Directions
# Newtown Arena Directions

ap = AdminPanel::Room::Base.new(:directions)

# TODO: Add this code into the room presenter logic when we get there!
ap.seed(id: 12, west: 35, hide_east: true)
ap.seed(id: 19, east_key: 'barracks_key')

ap.seed(id: 35, east: 12, west: 36)
ap.seed(id: 36, east: 35, west: 37)
ap.seed(id: 37, east: 36, north: 38)
ap.seed(id: 38, north: 39, south: 37)
ap.seed(id: 39, east: 40, south: 38)
ap.seed(id: 40, east: 41, west: 39)
ap.seed(id: 41, east: 42, west: 40)
ap.seed(id: 42, east: 43, west: 41)
ap.seed(id: 43, east: 44, west: 42)
ap.seed(id: 44, north: 51, east: 45, west: 43)
ap.seed(id: 45, east: 46, west: 44)
ap.seed(id: 46, north: 47, west: 45)
ap.seed(id: 47, north: 48, south: 46)
ap.seed(id: 48, east: 49, south: 47)
ap.seed(id: 49, east: 50, west: 48)
ap.seed(id: 50, west: 49)
ap.seed(id: 51, north: 52, south: 44)
ap.seed(id: 52, west: 53, south: 51)
ap.seed(id: 53, east: 52, west: 54)
ap.seed(id: 54, east: 53, west: 55)
ap.seed(id: 55, north: 56, east: 54, west: 58)
ap.seed(id: 56, north: 57, south: 55)
ap.seed(id: 57, north: 59, south: 56)
ap.seed(id: 58, east: 55)
ap.seed(id: 59, south: 57)

ap.seed(id: 6, west: 60)
ap.seed(id: 60, north: 61, south: 62, west: 63, east: 6)
ap.seed(id: 61, south: 60)
ap.seed(id: 62, north: 60)
ap.seed(id: 63, east: 60)
