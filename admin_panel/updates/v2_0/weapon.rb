# V2.0 Missing Weapon items

ap = AdminPanel::Base.new(:weapon)

ap.seed(
  id: 'ivory_dagger',
  name: 'Ivory Dagger',
  # TODO: Need a name for QuestArea1
  description: 'The flecks of gold engraved into the hilt disguise the fact that this weapon is the favoured amongst
the Bandits of the Forest Path. The Ivory in this weapon came from the Woolly Mammoths of QuestArea1',
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
  description: "A silver sword. Though basic by design, it looks as though it's rusted up due to lack of use",
  min_power: 2,
  max_power: 4
)
