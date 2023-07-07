# frozen_string_literal: true

# V0.1 Orc weapon drop

ap = AdminPanel::Seeder.new(:weapon)

ap.seed(
  id: 'orc_dagger',
  name: 'Orc Dagger',
  description: 'A tiny dagger concealed by the Orc. What it lacks in size '\
               'it makes up for in potency.',
  min_power: 1,
  max_power: 6
)
