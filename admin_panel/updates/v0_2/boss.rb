# frozen_string_literal: true

# V0.2 Boss Enemy #1 - Orc

ap = AdminPanel::Seeder.new(:boss)

ap.seed(
  id: 'orc',
  name: 'Orc',
  description: 'The Orc stands at over 8 feet tall. His Dagger that he is wielding is '\
'dripping with blood from its latest victim',
  weapon_id: 'orc_dagger',
  armor_id: 'orc_shield',
  lower_hp_limit: 100,
  upper_hp_limit: 100,
  accuracy: 0.9,
  lower_gold_limit: 140,
  upper_gold_limit: 400,
  xp: 22,
  xp_killshot: 500,
  stamina: 1
)
