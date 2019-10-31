# frozen_string_literal: true

# V1.0 Minor Content Update

ap = AdminPanel::Seeder.new(:description)

ap.seed(
  id: 5,
  description: 'There is a guard here who looks you up and down. You can leave freely '\
'for the Forest Path, or turn back to Newtown to the South.',
  location_id: 'newtown_gatehouse'
)

(10..20).each do |id_number|
  ap.seed(id: id_number, type: 'Outside')
end
