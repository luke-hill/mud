# V2.0 Missing (First), Potion items

ap = AdminPanel::Base.new(:hp_bonus_potion)

ap.seed(
  id: 'endurance_potion',
  name: 'Endurance Potion',
  use_message: 'You consume the potion, and feel enhanced almost immediately. Your maximum hp has increased by',
  description: 'This flask contains a potion with a green hue, it is rumoured to increase the damage you can
take before dying',
  value: 1
)
