# frozen_string_literal: true

# V2.0 New Key items, previously never seeded

ap = AdminPanel::Seeder.new(:key)

ap.seed(
  id: 'barracks_key',
  name: 'Barracks Key',
  description: 'This key has engravings on it similar to the ones seen on Weapons from the Barracks'
)

ap.seed(
  id: 'aurel_bark',
  name: 'Aurel Bark',
  description: 'A small shaving of Aurel Bark, lifted from the torn leathers of one of the numerous Bandits
that patrol and wreak havoc on the Forest Path.'
)

ap.seed(
  id: 'sylvanian_ingot',
  name: 'Sylvanian Ingot',
  description: 'This treasure looks like it could be forged into one of the rare Sylvanian Steel Blades.
But for now you consider that it must be a replica, as mining operations in Sylvania have never been found by man!'
)
