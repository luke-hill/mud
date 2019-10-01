module SpecSupport
  module VersionScripts
    module File
      require 'securerandom'

      def read_test_screen_logs
        ::File.read(file_location)
      end

      def remove_test_screen_logs
        ::File.delete(file_location)
      end

      def file_location
        "log/#{ENV['TEST_LOG_NAME']}.log"
      end
    end
  end
end
