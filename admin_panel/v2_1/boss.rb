# frozen_string_literal: true

# V2.1 Initial Phrase Messages from Bosses

ap = AdminPanel::Seeder.new(:boss)

ap.seed(
  id: 'orc',
  phrase1_chance: 0.25,
  phrase1_message: "I'll crush your puny bones with one stab of my dagger!",
  phrase2_chance: 0.25,
  phrase2_message: 'See this blood. This was what happened to the last adventurer who got lost HAHAHA!!!'
)
