# V1.0 Goblin Archer Bow

ap = AdminPanel::Seeder.new(:weapon)

ap.seed(
  id: 'small_bow',
  name: 'Small Bow',
  description: 'This bow is made out of a single, flimsy willow branch. Useful for hunting rabbits and not much more.',
  min_power: 3,
  max_power: 4
)
