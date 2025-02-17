# frozen_string_literal: true

module SpecSupport
  module File
    require 'securerandom'

    def read_test_screen_logs
      ::File.read(file_location)
    end

    def log_lines
      read_test_screen_logs.split("\n")[1..]
    end

    def switch_logging_to_temp_file
      MUD::Screen.output('BLANK')
      ENV['TEST_LOG_NAME'] = SecureRandom.uuid
      MUD::Screen.instance_variable_get(:@logger).reopen("log/#{log_name}.log")
    end

    def remove_test_screen_logs
      ::FileUtils.rm_f(file_location)
    end

    def file_location
      "log/#{log_name}.log"
    end

    def log_name
      ENV.fetch('TEST_LOG_NAME', 'rspec_tests')
    end
  end
end
