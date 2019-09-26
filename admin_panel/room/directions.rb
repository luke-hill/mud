require 'yaml'

module AdminPanel
  module Room
    class Directions < AdminPanel::Base
      private

      def directions
        @directions ||= directions_yml[id] || {}
      end

      def update
        puts "Data to be seeded: #{options}"
        puts "Existing Room Data: #{directions}"

        options.each do |key, value|
          directions[key.to_s] = value
        end

        directions_yml[id] = directions
        puts "New UPDATED Room Data: #{directions}"
      end

      def save
        File.write(
          '/home/luke/Code/mud/data/rooms/directions.yml',
          directions_yml.to_yaml
        )
      end

      def directions_yml
        @directions_yml ||= YAML.load_file('/home/luke/Code/mud/data/rooms/directions.yml')
      end
    end
  end
end
