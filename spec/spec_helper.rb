# frozen_string_literal: true

require 'rspec'
require 'shoulda/matchers'
require_relative '../app/game'
require_relative 'support/version_scripts/file'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecSupport::VersionScripts::File

  config.add_formatter :documentation
end

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true
