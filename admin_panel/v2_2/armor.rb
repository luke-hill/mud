# frozen_string_literal: true

# V2.2 Remove description from Quest Item (Checking that removing data works also!)

ap = AdminPanel::Seeder.new(:armor)

ap.seed(id: 'draz_ghuns_fleece', description: nil)
