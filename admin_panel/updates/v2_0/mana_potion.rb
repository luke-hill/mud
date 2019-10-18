# V2.0 Missing (First), Potion items

ap = AdminPanel::Seeder.new(:mana_potion)

ap.seed(
  id: 'lesser_magic_potion',
  name: 'Lesser Magic Potion',
  use_message: 'You open the vial of the potion, and swill the contents with vigour. The potion restores your mana by',
  description: 'A Basic Potion. This vial of liquid "promises" to heal the users magic power a small amount',
  value: 5
)
