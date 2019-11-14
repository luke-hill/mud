# frozen_string_literal: true

# V2.1 Initial Phrase Messages from Enemies

ap = AdminPanel::Seeder.new(:enemy)

ap.seed(
  id: 'no_enemy',
  phrase1_chance: 1,
  phrase1_message: "This should never be said",
  phrase2_chance: 0.9,
  phrase2_message: 'This also should never be said.'
)

ap.seed(
  id: 'goblin',
  phrase1_chance: 0.4,
  phrase1_message: "Argh. You'll never be good enough to beat me!",
  phrase2_chance: 0.2,
  phrase2_message: 'HAAAAAAhahAAAhAA.'
)

ap.seed(
  id: 'brawler',
  phrase1_chance: 0.2,
  phrase1_message: "GlugggggggGGG. Hurry up, the Taverns got more ale for me today.",
  phrase2_chance: 0.1,
  phrase2_message: 'Row, row, row your boat, gently down the stream. If you see a Drunk '\
"Brawler don't forget to scream."
)

ap.seed(
  id: 'goblin_archer',
  phrase1_chance: 0.5,
  phrase1_message: "..............",
  phrase2_chance: 0.75,
  phrase2_message: "You're mine."
)

ap.seed(
  id: 'bandit',
  phrase1_chance: 0.3,
  phrase1_message: "Do you like my Leathers. I fashioned them out of the last fool who dared "\
"to try steal from meeee! You'll be next.",
  phrase2_chance: 0.1,
  phrase2_message: 'Soooo you want to find out where we have our harvesting operation....'
)

ap.seed(
  id: 'wolf',
  phrase1_chance: 0.6,
  phrase1_message: "SnaarrRRRRRRRRRRL!!!",
  phrase2_chance: 0.5,
  phrase2_message: 'ROARRRRrRRRRR!!!'
)
