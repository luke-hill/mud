# frozen_string_literal: true

require 'rspec/core/rake_task'

desc 'Seed the game using the seed files'
task :seed do
  require_relative 'admin_panel/seeder'
  AdminPanel::Seeder.seed_all_versions
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec
