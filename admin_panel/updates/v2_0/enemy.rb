# frozen_string_literal: true

# V2.0 Dropped Items table for Goblin

ap = AdminPanel::Seeder.new(:enemy)

ap.seed(
  id: 'goblin',
  dropped_potion_id: 'lesser_healing_potion',
  dropped_potion_chance: 0.3,
  dropped_potion_message: 'Amongst the corpse of the Goblin, you stumble across a Potion... Likely looted from one of the '\
                          'victims he cornered in the Dungeon. It falls to the floor, along with its lifeless corpse.',
  dropped_weapon_id: 'goblin_axe',
  dropped_weapon_chance: 0.05,
  dropped_weapon_message: 'The Goblin dropped its Goblin Axe.'
)
