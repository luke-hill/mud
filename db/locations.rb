start = Time.now
puts 'Creating Locations'

Location.create(town: 'Newtown', area: 'Town Square')
Location.create(town: 'Newtown', area: 'Travelling Merchants Shop')
Location.create(town: 'Newtown', area: 'Training Area')
Location.create(town: 'Newtown', area: 'Basic Training Guild')
Location.create(town: 'Newtown', area: 'Gatehouse')
Location.create(town: 'Newtown', area: 'Outskirts')
Location.create(town: 'Newtown', area: 'Residential Area')
Location.create(area: 'Dusty Path') #To fix

puts "#{Location.count} Locations created in #{(Time.now - start).round(2)}s"
