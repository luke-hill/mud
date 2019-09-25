require 'yaml'

module AdminPanel
  module Room
    class Directions
      attr_reader :options

      def self.seed(options)
        new(options).seed
      end

      def initialize(options)
        @options = options
      end

      def seed
        raise ArgumentError, 'Room ID not set' unless id

        update_directions
        save
      end

      private

      def id
        @id ||= options.delete(:id)
      end

      def directions
        @directions ||= directions_yml[id] || {}
      end

      def update_directions
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
