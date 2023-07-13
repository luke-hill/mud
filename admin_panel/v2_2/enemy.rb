# frozen_string_literal: true

# V2.2 Mini bug-fix for Accuracy ratings

ap = AdminPanel::Seeder.new(:enemy)

ap.seed(id: 'goblin', accuracy: 0.75)
ap.seed(id: 'brawler', accuracy: 0.66)
