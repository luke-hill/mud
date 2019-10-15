module MUD
  class Screen
    class << self
      def output(msg)
        MUD::Logger.debug("SCREEN - #{msg}")
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
        File.absolute_path('/home/luke/Code/mud/log/screen.log')
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
