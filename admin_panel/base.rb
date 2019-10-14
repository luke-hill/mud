require 'yaml'

module AdminPanel
  class Base
    attr_reader :type
    attr_accessor :options

    def initialize(type)
      @type = type
    end

    def seed(options)
      self.remove_instance_variable(:@id) rescue nil
      self.options = options
      raise ArgumentError, 'ID not set' unless id

      update
      save
    end

    private

    def yaml_locations
      {
        boss: '/home/luke/Code/mud/data/enemies/boss.yml',
        enemy: '/home/luke/Code/mud/data/enemies/enemy.yml',
        descriptions: '/home/luke/Code/mud/data/rooms/descriptions.yml',
        directions: '/home/luke/Code/mud/data/rooms/directions.yml',
        locations: '/home/luke/Code/mud/data/rooms/locations.yml'
      }
    end

    def id
      @id ||= options.delete(:id)
    end

    def update
      puts "Data to be seeded: #{options}"
      puts "Existing Data: #{data}"

      # options.each do |key, value|
      #   data[key.to_s] = value
      # end

      # yml_file[id] = data
      stringified_keys_hash = options.collect{|k,v| [k.to_s, v]}.to_h
      new_vals = { id => stringified_keys_hash }
      new_full_hash = yml_file.merge(new_vals)

      File.write(yml_file_location, new_full_hash.to_yaml)
      puts "New UPDATED ID: #{id} Data: #{data}"
    end

    def data
      @data = yml_file && yml_file[id] || {}
    end

    def yml_file
      @yml_file = begin
        YAML.load_file(yml_file_location)
      rescue Errno::ENOENT
        puts "File does not exist @ #{yml_file_location}. Creating new blank YML file."
        File.open(yml_file_location, 'w+') {|f| f.write({}) }
        YAML.load_file(yml_file_location)
      end
    end

    def save
      File.write(yml_file_location, yml_file.to_yaml)
    end

    def yml_file_location
      yaml_locations[type]
    end
  end
end
