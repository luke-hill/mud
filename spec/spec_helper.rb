# frozen_string_literal: true

require 'rspec'
require_relative '../app/game'
require_relative 'support/file'
require_relative 'support/console'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecSupport::File
  config.include SpecSupport::Console

  config.add_formatter :documentation
end
