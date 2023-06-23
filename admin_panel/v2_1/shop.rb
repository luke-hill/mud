# frozen_string_literal: true

# V2.1 First shop data - in Newtown at Draz'ghun the Potion Merchant - Room ID #3.
# This lists the items available to be bought/sold at the first shop

ap = AdminPanel::Seeder.new(:shop)

ap.seed(
  id: 3,
  potions: [
    { id: 'lesser_healing_potion', cost: 25, resell: 10 },
    { id: 'endurance_potion', resell: 200 }
  ]
)
