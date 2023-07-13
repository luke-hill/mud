# frozen_string_literal: true

module MUD
  # The Games Screen Utility - Visible Console
  # This will store external messages that are shown to the user on the screen
  #
  # These messages are displayed to the player, stored in a screen log file, and also
  # copied into the main game log file, so the traceability is maximised.
  class Screen
    class << self
      def output(msg)
        Logger.debug("SCREEN - #{msg}")
        logger.info(msg)
        puts msg
        msg
      end

      private

      def logger
        @logger ||= create_logger
      end

      def create_logger
        ::Logger.new(name, archived_logs, log_size_in_kb).tap do |logger|
          logger.level = :info
          logger.formatter = proc do |severity, datetime, _, msg|
            "#{datetime}:#{severity} - #{msg}\n"
          end
        end
      end

      def name
        File.join(Dir.pwd, 'log/screen.log')
      end

      def archived_logs
        5
      end

      def log_size_in_kb
        1_048_576
      end
    end
  end
end
