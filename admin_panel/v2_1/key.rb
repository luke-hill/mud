# frozen_string_literal: true

# V2.1 Initial Use Messages for some keys

ap = AdminPanel::Seeder.new(:key)

ap.seed(
  id: 'barracks_key',
  use_message: 'You hear a click as you turn the key. The old oak door slowly opens.'
)

ap.seed(
  id: 'aurel_bark',
  use_message: 'You hand the Ranger the Aurel Bark. He takes one look at it and remarks that '\
"'It's not enough', for him to work with. And he needs more ..... a lot more."
)