# frozen_string_literal: true

module MUD
  # The Games Logger Utility
  # This will store internal messages such as calculation logic, debug logic and any
  # errors that might be propagated up if something goes awry
  #
  # These messages are NOT displayed to the player
  class Logger
    class << self
      extend Forwardable

      def logger
        @logger ||= create_logger
      end

      private

      def create_logger
        ::Logger.new(name, archived_logs, log_size_in_kb).tap do |logger|
          logger.level = log_level
          logger.formatter = proc do |severity, datetime, _, msg|
            "#{datetime}:#{severity} - #{msg}\n"
          end
        end
      end

      def name
        File.join(Dir.pwd, 'log/mud.log')
      end

      def archived_logs
        5
      end

      def log_size_in_kb
        1_048_576
      end

      private def log_level
        ENV.fetch('LOG_LEVEL', 'debug')
      end

      def_delegators :logger, :debug, :info, :warn, :error, :fatal, :unknown
    end
  end
end
