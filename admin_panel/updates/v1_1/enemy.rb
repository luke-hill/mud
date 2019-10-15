# V1.1 Enemy Creations

ap = AdminPanel::Base.new(:enemy)

ap.seed(
  id: 'bandit',
  name: 'Bandit',
  description: 'The Bandit is a typical ruffian. Skulking in the shadows. He preys on targets roaming the Forest Path.',
  weapon: 'ivory_dagger',
  armor: 'bandit_leathers', # todo: bandit leathers to create
  lower_hp_limit: 28,
  upper_hp_limit: 40,
  accuracy: 0.85,
  lower_gold_limit: 17,
  upper_gold_limit: 29,
  xp: 8,
  xp_killshot: 80,
  stamina: 1
)

ap.seed(
  id: 'wolf',
  name: 'Wolf',
  description: "This Wolf is unlike the normal Rabid Wolves you see floating around. Its fangs are dripping with blood,
and it eyes you up... Like you're its next meal!",
  weapon: 'sharp_fangs', # todo: sharp fangs to create - high damage
  armor: 'wolf_hide', # todo: wolf hide to create
  lower_hp_limit: 85,
  upper_hp_limit: 114,
  accuracy: 0.6,
  lower_gold_limit: 14,
  upper_gold_limit: 18,
  xp: 12,
  xp_killshot: 150,
  stamina: 1
)
