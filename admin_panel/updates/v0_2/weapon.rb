# V0.1 Basic Weapon items

ap = AdminPanel::Base.new(:weapon)

ap.seed(
  id: 'orc_dagger',
  name: 'Orc Dagger',
  description: 'A tiny dagger concealed by the Orc. What it lacks in size it makes up for in potency.',
  min_power: 1,
  max_power: 6
)
