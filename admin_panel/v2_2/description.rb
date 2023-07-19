# frozen_string_literal: true

# V2.2 Bugfix for KTP

ap = AdminPanel::Seeder.new(:description)

ap.seed(id: 50, ktp: true)
