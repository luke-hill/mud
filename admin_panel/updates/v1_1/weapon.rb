# frozen_string_literal: true

# V1.1 New Enemy Weapons

ap = AdminPanel::Seeder.new(:weapon)

ap.seed(
  id: 'sharp_fangs',
  name: 'Sharp Fangs',
  description: 'The sharp fangs of the Forest Path Wolves. They glisten with blood '\
'from their latest victim.',
  min_power: 11,
  max_power: 17
)
