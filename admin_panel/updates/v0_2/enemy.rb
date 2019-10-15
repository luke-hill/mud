# V0.2 Enemy Creations

ap = AdminPanel::Base.new(:enemy)

ap.seed(
  id: 'no_enemy',
  name: 'No Enemy',
  description: 'This is Not an Enemy',
  weapon: 'fists',
  armor: 'unarmored',
  lower_hp_limit: 0,
  upper_hp_limit: 0,
  accuracy: 0,
  lower_gold_limit: 0,
  upper_gold_limit: 0,
  xp: 0,
  xp_killshot: 0,
  stamina: 0
)

ap.seed(
  id: 'goblin',
  name: 'Goblin',
  description: "A Hideous creature, borne out of pure evil! Luckily this one is just an infant, so shouldn't pose much threat",
  weapon: 'goblin_axe',
  armor: 'unarmored',
  lower_hp_limit: 5,
  upper_hp_limit: 13,
  accuracy: 0.7,
  lower_gold_limit: 0,
  upper_gold_limit: 3,
  xp: 2,
  xp_killshot: 10,
  stamina: 1
)

ap.seed(
  id: 'brawler',
  name: 'Brawler',
  description: "This Brawler is one of the many test 'subjects' that have come to the arena to earn their weekly ale money.
He staggers at you with a half rusted sword, and gargles something in-between swigs from his ale bottle.",
  weapon: 'rusty_sword',
  armor: 'vest',
  lower_hp_limit: 7,
  upper_hp_limit: 13,
  accuracy: 0.65,
  lower_gold_limit: 5,
  upper_gold_limit: 8,
  xp: 5,
  xp_killshot: 20,
  stamina: 1
)
