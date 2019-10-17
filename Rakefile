desc 'seed the game from a specific version'
task :seed, :version do |task, args|
  puts "Seeding Version #{args.version}"
  require_relative 'admin_panel/updates/seeder'
  seed(args.version)
end
