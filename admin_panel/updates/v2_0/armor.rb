# frozen_string_literal: true

# V2.0 Missing Armor items

ap = AdminPanel::Seeder.new(:armor)

ap.seed(
  id: 'cloak',
  name: 'Cloak',
  description: 'A Blue Cloak that has been discarded by a mage. It provides a basic level of defensive cover',
  defense: 4
)

ap.seed(
  id: 'draz_ghuns_fleece',
  name: "Draz'Ghun's Fleece",
  description: 'This fleece, straight out of his shop in Newtown, is said to be the perfect accompaniment '\
'for a travelling warrior',
  defense: 5
)
