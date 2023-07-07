# frozen_string_literal: true

# V2.1 Initial Use Messages for keys
# New Refined Sylvanian Ingot, without a use (Yet)

ap = AdminPanel::Seeder.new(:key)

ap.seed(
  id: 'barracks_key',
  use_message: 'You hear a click as you turn the key. The old oak door slowly opens.'
)

ap.seed(
  id: 'aurel_bark',
  use_message: "You hand the Ranger the Aurel Bark. He takes one look at it and remarks that it's not enough, for him to work with. "\
               "He needs more ..... a lot more."
)

ap.seed(
  id: 'sylvanian_ingot',
  use_message: "You hand the Ranger the Sylvanian Ingot.... But he steps back aghast.... \"I've not seen something like this in"\
               "decades! - I wouldn't know where to start... Maybe try the Smiths in Sovereign City.\""
)

ap.seed(
  id: 'refined_sylvanian_ingot',
  name: 'Refined Sylvanian Ingot',
  description: 'This is a smaller, slightly purer form of Sylvanian Steel. This definitely looks closer to the blades that '\
               'could have been used in their armies long ago!. Given they were known for their metallurgy, it is unsurprising that the '\
               'sheen coming off it dazzles in the moonlight, glistening with a brilliant silver hue.'
)
