# V0.1 Basic Weapon items

ap = AdminPanel::Base.new(:weapon)

ap.seed(
  id: 'fists',
  name: 'Fists',
  description: 'Fighting with your fists. Not much use when it comes to fighting someone with a sword!',
  min_power: 0,
  max_power: 1
)

ap.seed(
  id: 'goblin_axe',
  name: 'Goblin Axe',
  description: 'A primitive axe fashioned out of a branch and a piece of old flint, tied together with a single orc hair',
  min_power: 1,
  max_power: 3
)

ap.seed(
  id: 'knife',
  name: 'Knife',
  description: 'A primitive knife used by huntsmen',
  min_power: 1,
  max_power: 2
)