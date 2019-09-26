require 'yaml'

module AdminPanel
  module Room
    class Directions < AdminPanel::Base
      private

      def directions
        @directions ||= yml_file[id] || {}
      end

      def update
        puts "Data to be seeded: #{options}"
        puts "Existing Data: #{directions}"

        options.each do |key, value|
          directions[key.to_s] = value
        end

        yml_file[id] = directions
        puts "New UPDATED Data: #{directions}"
      end

      def yml_file_location
        '/home/luke/Code/mud/data/rooms/directions.yml'
      end
    end
  end
end
