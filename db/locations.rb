start = Time.now
puts 'Creating Locations'

#v0.1 locations - all to move
Location.create(town: 'Newtown', area: 'Town Square')
Location.create(town: 'Newtown', area: 'Travelling Merchants Shop')
Location.create(town: 'Newtown', area: 'Training Area')
Location.create(town: 'Newtown', area: 'Basic Training Guild')
Location.create(town: 'Newtown', area: 'Gatehouse')
Location.create(town: 'Newtown', area: 'Outskirts')
Location.create(town: 'Newtown', area: 'Residential District')
Location.create(town: 'Newtown', area: 'Residential District Crossroads')
Location.create(town: 'Newtown', area: 'House')
Location.create(town: 'Newtown', area: 'Bank')
Location.create(area: 'Forest Path')
Location.create(area: 'Barracks')

puts "#{Location.count} Locations created in #{(Time.now - start).round(2)}s"
