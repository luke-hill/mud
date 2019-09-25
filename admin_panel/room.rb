require 'yaml'

module AdminPanel
  class Room
    def initialize(seed: false)
      puts seed
      return if seed

      puts 'dir -> Edit directions'
      puts 'desc -> Edit descriptions'

      case gets.chomp.downcase
      when 'dir'; then edit_direction_data
      when 'desc'; then edit_description_data
      else puts 'Quitting Room Admin'
      end
    end

    def seed(options)
      raise ArgumentError unless options.key?(:id)

      puts "Seeding Data for #{options}"
      room_data = directions_yml[options.delete(:id)]
      puts "Existing Room Data: #{room_data}"

      options.each do |key, value|
        string_key = key.to_s
        room_data[string_key] = value
      end

      puts "New UPDATED Room Data: #{room_data}"
    end

    private

    def edit_direction_data
      puts 'You want to edit directions?'
      sleep 1.5
      dump_direction_data

      puts 'add -> Add a new direction'
      puts 'edit -> Edit an existing description'

      case gets.chomp.downcase
      when 'add'; then add_new_direction
      when 'edit'; then edit_existing_direction
      else puts 'Quitting Room Admin'
      end
    end

    def add_new_direction
      new_room_id = number_of_directions_set + 1

      puts 'What room_id to connect north?'
      north_room_id = gets.chomp.downcase

      puts 'What room_id to connect east?'
      east_room_id = gets.chomp.downcase

      puts 'What room_id to connect south?'
      south_room_id = gets.chomp.downcase

      puts 'What room_id to connect west?'
      west_room_id = gets.chomp.downcase

      save_direction_data(
        new_room_id,
        north_room_id,
        east_room_id,
        south_room_id,
        west_room_id
      )
    end

    def edit_existing_direction
      puts 'What room_id to edit directions for?'
      room_id = gets.chomp.downcase

      puts 'What room_id to connect north?'
      north_room_id = gets.chomp.downcase

      puts 'What room_id to connect east?'
      east_room_id = gets.chomp.downcase

      puts 'What room_id to connect south?'
      south_room_id = gets.chomp.downcase

      puts 'What room_id to connect west?'
      west_room_id = gets.chomp.downcase

      save_direction_data(
        room_id,
        north_room_id,
        east_room_id,
        south_room_id,
        west_room_id
      )
    end

    def save_direction_data(room_id, north_room_id, east_room_id, south_room_id, west_room_id)
      directions_yml[room_id] = {
        'north' => north_room_id,
        'east' => east_room_id,
        'south' => south_room_id,
        'west' => west_room_id
      }

      File.write(
        '/home/luke/Code/mud/data/rooms/directions.yml',
        directions_yml.to_yaml
      )
    end

    def dump_direction_data
      directions_yml.keys.each do |key|
        puts("Room #{key}: #{directions_yml[key]}")
      end
    end

    def number_of_directions_set
      directions_yml.keys.length
    end

    def directions_yml
      @directions_yml ||= YAML.load_file('/home/luke/Code/mud/data/rooms/directions.yml')
    end
  end
end
