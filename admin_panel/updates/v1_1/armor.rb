# V1.1 New Enemy Armors

ap = AdminPanel::Seeder.new(:armor)

ap.seed(
  id: 'bandit_leathers',
  name: 'Bandit Leathers',
  description: "These leathers have been put together piecemeal. They're flaking at the edges, and look as if they could
fall apart at any minute. They look as if they used to be part of something much greater.",
  defense: 2
)

ap.seed(
  id: 'wolf_hide',
  name: 'Wolf Hide',
  description: 'The smooth silken fur of the Forest Path Wolves. This looks like it offers average protection for the
beasts. It is adorned with a few puncture marks where previous adventurers have attempted to slay the beasts.',
  defense: 3
)
