require '../base'
require '../enemies/enemy'
require '../room/directions'
require '../room/descriptions'

def seed(version)
  Dir[File.absolute_path("./#{version}/*.rb")].each { |file| require file }
end

def seed_all
  current_seed_versions.each do |version|
    seed(version)
  end
end

def current_seed_versions
  Dir.glob('*').select { |f| File.directory? f }.sort
end

Dir[File.absolute_path("./v0_1/room_locations.rb")].each { |file| require file }