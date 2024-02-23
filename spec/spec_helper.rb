# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  coverage_dir 'tmp/coverage'

  add_filter '/spec'

  minimum_coverage 98
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
  config.include SpecSupport::Player
  config.include SpecSupport::Room

  config.include MUD::Helpers::Data
  config.include MUD::Helpers::Unabbreviater

  config.add_formatter :documentation

  config.before do
    swallow_console_spam
    switch_logging_to_temp_file
  end

  config.after do
    remove_test_screen_logs
  end
end
