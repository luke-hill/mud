# frozen_string_literal: true

# V2.0 Adding guards to locations

ap = AdminPanel::Seeder.new(:location)

ap.seed(id: 'newtown_town_square', guards: true)
ap.seed(id: 'newtown_travelling_merchants_shop', guards: true)
ap.seed(id: 'newtown_training_area', guards: false)
ap.seed(id: 'newtown_basic_training_guild', guards: true)
ap.seed(id: 'newtown_gatehouse', guards: true)
ap.seed(id: 'newtown_outskirts', guards: true)
ap.seed(id: 'newtown_residential_district', guards: true)
ap.seed(id: 'newtown_residential_district_crossroads', guards: true)
ap.seed(id: 'newtown_house', guards: true)
ap.seed(id: 'newtown_bank', guards: true)
ap.seed(id: 'forest_path', guards: false)
ap.seed(id: 'barracks', guards: false)
ap.seed(id: 'sovereign_city_gatehouse', guards: true)
