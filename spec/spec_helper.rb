# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.add_formatter :documentation
end

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

# frozen_string_literal: true

require 'spec_helper'
require 'factory_girl'
require 'support/factory_girl'
require 'shoulda/matchers'
require_relative '../app/game'
