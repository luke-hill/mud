# V0.2 Newtown district directions

ap = AdminPanel::Room::Base.new(:directions)

ap.seed(id: 21, north: 2, south: 22)
ap.seed(id: 22, north: 21, south: 23)
ap.seed(id: 23, north: 22, south: 24, east: 34)
ap.seed(id: 24, north: 23, south: 25)
ap.seed(id: 25, north: 24, south: 26)
ap.seed(id: 26, north: 25, south: 27, east: 32, west: 33)
ap.seed(id: 27, north: 26, south: 28)
ap.seed(id: 28, north: 27, south: 29, east: 30, west: 31)
ap.seed(id: 29, north: 28)
ap.seed(id: 30, west: 28)
ap.seed(id: 31, east: 28)
ap.seed(id: 32, west: 26)
ap.seed(id: 33, east: 26)
ap.seed(id: 34, west: 23)
