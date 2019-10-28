# frozen_string_literal: true

require 'rspec/core/rake_task'

desc 'Seed the game from a specific version (Provided)'
task :seed, :version do |_, args|
  puts "Seeding Version #{args.version}"
  require_relative 'admin_panel/seeder'
  AdminPanel::Seeder.seed_version(args.version)
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec
