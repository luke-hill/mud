# frozen_string_literal: true

# V1.0 Enemy Creations

ap = AdminPanel::Seeder.new(:enemy)

ap.seed(
  id: 'goblin_archer',
  name: 'Goblin Archer',
  description: 'Concealing himself in the distance, the Goblin Archer uses his metronomic '\
'eyes to aid his accuracy',
  weapon_id: 'small_bow',
  armor_id: 'unarmored',
  lower_hp_limit: 35,
  upper_hp_limit: 42,
  accuracy: 0.95,
  lower_gold_limit: 14,
  upper_gold_limit: 40,
  xp: 14,
  xp_killshot: 150,
  stamina: 1
)
