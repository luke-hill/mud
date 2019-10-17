desc 'Seed the game from a specific version (Provided)'
task :seed, :version do |_, args|
  puts "Seeding Version #{args.version}"
  require_relative 'admin_panel/seeder'
  seed(args.version)
end
