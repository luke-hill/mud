# frozen_string_literal: true

# V2.0 Missing (First), Potions

ap = AdminPanel::Seeder.new(:healing_potion)

ap.seed(
  id: 'lesser_healing_potion',
  name: 'Lesser Healing Potion',
  use_message: 'You open the vial of the potion, and swill the contents with vigour. The potion heals you by',
  description: 'A Basic Potion. This vial of liquid "promises" to heal the users injuries a small amount.',
  value: 10
)
