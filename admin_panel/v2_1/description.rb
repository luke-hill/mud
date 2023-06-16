# frozen_string_literal: true

# V2.1 Bugfix for KTP

ap = AdminPanel::Seeder.new(:description)

ap.seed(id: 13, ktp: true)
