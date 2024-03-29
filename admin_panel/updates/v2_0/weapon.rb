# frozen_string_literal: true

# V2.0 New Weapons

ap = AdminPanel::Seeder.new(:weapon)

ap.seed(
  id: 'ivory_dagger',
  name: 'Ivory Dagger',
  description: 'The flecks of gold engraved into the hilt disguise the fact that this weapon is the favoured amongst the ' \
               'Bandits of the Forest Path. The Ivory in this weapon came from the Woolly Mammoths of Avradia',
  min_power: 5,
  max_power: 8
)

ap.seed(
  id: 'netherspite_blade',
  name: 'Netherspite Blade',
  description: 'Aged and worn from battles gone by, you can just make out a slight purple hue from the hilt',
  min_power: 3,
  max_power: 10
)

ap.seed(
  id: 'rusty_sword',
  name: 'Rusty Sword',
  description: 'A silver sword. Though basic by design, it looks as though it has rusted up due to lack of use',
  min_power: 2,
  max_power: 4
)
