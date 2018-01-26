start = Time.now
puts 'Creating Enemies'

Enemy.create(
  name: 'No Enemy', description: 'This is Not an Enemy',
  weapon_id: 0, armor_id: 0, lower_hp_limit: 0, upper_hp_limit: 0,
  accuracy: 0, lower_gold_limit: 0, upper_gold_limit: 0,
  xp: 0, xp_killshot: 0, stamina: 0
)
Enemy.create(
  name: 'Goblin', description: 'This Goblin is a Test',
  weapon_id: 2, armor_id: 1, lower_hp_limit: 4, upper_hp_limit: 12,
  accuracy: 0.6, lower_gold_limit: 0, upper_gold_limit: 3,
  xp: 2, xp_killshot: 10, stamina: 1
)
Enemy.create(
  name: 'Brawler', description: 'This Brawler is a Test',
  weapon_id: 3, armor_id: 2, lower_hp_limit: 7, upper_hp_limit: 13,
  accuracy: 0.65, lower_gold_limit: 5, upper_gold_limit: 8,
  xp: 5, xp_killshot: 20, stamina: 1
)

puts "#{Enemy.count} Enemies created in #{(Time.now - start).round(2)}s"
