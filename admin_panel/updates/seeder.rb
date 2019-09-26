require 'admin_panel/base'
require 'admin_panel/enemy/enemies'
require 'admin_panel/room/directions'

def seed(version)
  Dir[File.absolute_path("./#{version}/*.rb")].each { |file| require file }
end

def seed_all
  current_seed_versions.each do |version|
    seed(version)
  end
end

def current_seed_versions
  Dir.glob('*').select { |f| File.directory? f }
end
