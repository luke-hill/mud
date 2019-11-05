# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  coverage_dir "tmp/coverage"

  add_group "App", "app"
  add_group "Spec", "spec"

  minimum_coverage 40
end

require 'rspec'
require 'delegate_matcher'

require_relative '../app/game'
require_relative 'support/file'
require_relative 'support/console'
require_relative 'support/factory'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecSupport::File
  config.include SpecSupport::Console
  config.include SpecSupport::Factory

  config.add_formatter :documentation
end
