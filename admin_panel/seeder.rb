require_relative 'base'

def seed(version)
  Dir[File.absolute_path("./admin_panel/updates/#{version}/*.rb")].each { |file| require file }
end

def seed_all
  current_seed_versions.each do |version|
    seed(version)
  end
end

def current_seed_versions
  Dir.glob('*').select { |f| File.directory? f }.sort
end
