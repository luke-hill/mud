# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  coverage_dir 'tmp/coverage'

  add_filter '/spec'

  minimum_coverage 91
end

require 'rspec'
require 'delegate_matcher'

require_relative '../app/game'
require_relative '../app/play'

ENV['DATA_SOURCE'] = 'spec/support/fixtures'

Dir[File.absolute_path('./spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include SpecSupport::Console
  config.include SpecSupport::Factory
  config.include SpecSupport::File

  config.add_formatter :documentation

  config.before do
    swallow_console_spam
  end
end
