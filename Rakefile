desc 'seed it'
task :seed, :version do |task, version|
  puts "Seeding Version #{version}"
  p version
  require_relative 'admin_panel/updates/seeder'
  seed(version)
end
