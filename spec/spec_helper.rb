# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  coverage_dir 'tmp/coverage'

  add_group 'App', 'app'
  add_group 'Spec', 'spec'

  minimum_coverage 80
end

require 'rspec'
require 'delegate_matcher'

require_relative '../app/game'

require_relative 'support/console'
require_relative 'support/factory'
require_relative 'support/file'
require_relative 'support/room'

require_relative 'support/shared_examples/movement'

RSpec.configure do |config|
  config.include SpecSupport::Console
  config.include SpecSupport::Factory
  config.include SpecSupport::File
  config.include SpecSupport::Room

  config.add_formatter :documentation
end
