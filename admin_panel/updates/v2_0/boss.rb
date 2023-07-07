# frozen_string_literal: true

# V2.0 Dropped Items table for Boss

ap = AdminPanel::Seeder.new(:boss)

ap.seed(
  id: 'orc',
  dropped_armor_id: 'orc_shield',
  dropped_armor_chance: 0.08,
  dropped_armor_message: 'Just before landing the fateful blow, you knock the shield out '\
                         'of the Orcs Hand. After hitting the floor, it cracks slightly, but you notice it is '\
                         'still of some limited use.'
)
