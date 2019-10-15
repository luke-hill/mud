# V0.2 Boss Enemy Creations

ap = AdminPanel::Base.new(:boss)

ap.seed(
  id: 'orc',
  name: 'Orc',
  description: 'The Orc stands at over 8 feet tall. His Dagger that he is wielding is dripping with blood from its latest victim',
  weapon: 'orc_dagger',
  armor: 'orc_shield',
  lower_hp_limit: 100,
  upper_hp_limit: 100,
  accuracy: 0.9,
  lower_gold_limit: 140,
  upper_gold_limit: 400,
  xp: 22,
  xp_killshot: 500,
  stamina: 1
)