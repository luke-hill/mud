# V1.0 Enemy Creations

ap = AdminPanel::Enemy::Enemies

ap.seed(
  id: 'goblin_archer',
  name: 'Goblin Archer',
  description: 'Concealing himself in the distance, the Goblin Archer uses his metronomic eyes to aid his accuracy',
  weapon: 'short_bow',
  armor: 'unarmored',
  lower_hp_limit: 35,
  upper_hp_limit: 42,
  accuracy: 0.95,
  lower_gold_limit: 14,
  upper_gold_limit: 40,
  xp: 2,
  xp_killshot: 10,
  stamina: 1
)

# TODO: The xp / xp killshot values here are incorrect