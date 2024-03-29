# frozen_string_literal: true

# V0.1 Newtown and first Dungeon

ap = AdminPanel::Seeder.new(:direction)

ap.seed(id: 1, north: 9, east: 2, west: 8)
ap.seed(id: 2, north: 3, west: 1)
ap.seed(id: 3, north: 4, south: 2, west: 9)
ap.seed(id: 4, south: 3, west: 5)
ap.seed(id: 5, north: 10, south: 9, east: 4, west: 6)
ap.seed(id: 6, south: 7, east: 5)
ap.seed(id: 7, north: 6, south: 8, east: 9)
ap.seed(id: 8, north: 7, east: 1)
ap.seed(id: 9, north: 5, south: 1, east: 3, west: 7)
ap.seed(id: 10, north: 11, south: 5)
ap.seed(id: 11, north: 12, south: 10)
ap.seed(id: 12, south: 11, east: 13)
ap.seed(id: 13, east: 14, west: 12)
ap.seed(id: 14, east: 15, west: 13)
ap.seed(id: 15, east: 16, west: 14)
ap.seed(id: 16, east: 17, west: 15)
ap.seed(id: 17, east: 18, west: 16)
ap.seed(id: 18, east: 19, west: 17)
ap.seed(id: 19, east: 20, west: 18)
ap.seed(id: 20, west: 19)
