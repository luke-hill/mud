# frozen_string_literal: true

# V2.1 First shop data - in Newtown at Draz'Ghun the Potion Merchant - Room ID #3.
# This lists the hard-coded items at the first shop

ap = AdminPanel::Seeder.new(:shop)

ap.seed(id: 3, item_id: 'lesser_healing_potion', cost: 25, resell: 10)
ap.seed(id: 3, item_id: 'endurance_potion', resell: 200)
