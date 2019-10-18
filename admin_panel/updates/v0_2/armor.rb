# V0.2 Basic Armor items

ap = AdminPanel::Seeder.new(:armor)

ap.seed(
  id: 'unarmored',
  name: 'Unarmored',
  description: 'Just skin and bones! nothing that will stop an enemies strike',
  defense: 0
)

ap.seed(
  id: 'vest',
  name: 'Vest',
  description: 'An Airy vest that lets you enjoy the sun, but offers nothing in the way of protection',
  defense: 1
)

ap.seed(
  id: 'orc_hide',
  name: 'Orc Hide',
  description: 'Though primitive in design, these interlocking scales form a sturdy barrier against attack',
  defense: 8
)

ap.seed(
  id: 'orc_shield',
  name: 'Orc Shield',
  description: 'This shield is fashioned from the bones of its last few victims. It is covered in spikes that offer '\
'some basic protection.',
  defense: 2
)
