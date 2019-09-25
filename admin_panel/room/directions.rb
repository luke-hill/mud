require 'yaml'

module AdminPanel
  module Room
    class Directions
      attr_accessor :room_id, :room_data

      def self.seed(options)
        new(options).seed(options)
      end

      def initialize(options)
        @room_id = options.delete(:id)
        @room_data = directions_yml[room_id] || {}
      end

      def seed(options)
        raise ArgumentError, 'Room ID not set' unless room_id

        update_direction_data(options, room_data)
        save_updates
      end

      private

      def update_direction_data(options, room_data)
        puts "Seeding Data for #{options}"
        puts "Existing Room Data: #{room_data}"

        options.each do |key, value|
          string_key = key.to_s
          room_data[string_key] = value
        end

        directions_yml[room_id] = room_data
        puts "New UPDATED Room Data: #{room_data}"
      end

      def save_updates
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
