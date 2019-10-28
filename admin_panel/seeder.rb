require 'yaml'
require_relative '../app/core_ext/all'

module AdminPanel
  class Seeder
    attr_reader :type
    attr_accessor :options

    class << self
      def seed_version(version)
        Dir[File.absolute_path("./admin_panel/updates/#{version}/*.rb")].each { |file| require file }
      end

      def seed_all_versions
        current_seed_versions.each do |version|
          seed_version(version)
        end
      end

      private

      def current_seed_versions
        Dir.glob('*').select { |f| File.directory? f }.sort
      end
    end

    def initialize(type)
      @type = type
    end

    def seed(options)
      clear_id
      self.options = options
      raise ArgumentError, 'ID not set' unless id

      update
      save
    end

    private

    def clear_id
      remove_instance_variable(:@id) if instance_variable_defined?(:@id)
    end

    def id
      @id ||= options.delete(:id)
    end

    def update
      puts "Data to be seeded: #{options}"
      File.write(yml_file_location, full_values.to_yaml)
      puts "New UPDATED ID: #{id} Data: #{data}"
    end

    def yml_file_location
      yaml_locations[type]
    end

    def yaml_locations
      {
        armor: "#{home_dir}/data/items/armor.yml",
        boss: "#{home_dir}/data/enemies/boss.yml",
        description: "#{home_dir}/data/rooms/description.yml",
        direction: "#{home_dir}/data/rooms/direction.yml",
        enemy: "#{home_dir}/data/enemies/enemy.yml",
        healing_potion: "#{home_dir}/data/items/potions/healing.yml",
        hp_bonus_potion: "#{home_dir}/data/items/potions/hp_bonus.yml",
        key: "#{home_dir}/data/items/key.yml",
        location: "#{home_dir}/data/rooms/location.yml",
        mana_potion: "#{home_dir}/data/items/potions/mana.yml",
        weapon: "#{home_dir}/data/items/weapon.yml"
      }
    end

    def full_values
      yml_file.merge(new_values)
    end

    def yml_file
      YAML.load_file(yml_file_location)
    rescue Errno::ENOENT
      puts "File does not exist @ #{yml_file_location}. Creating new blank YML file."
      File.open(yml_file_location, 'w+') {|f| f.write({}) }
      YAML.load_file(yml_file_location)
    end

    def new_values
      { id => data.merge(options.stringify_keys) }
    end

    def data
      yml_file[id] || {}
    end

    def save
      File.write(yml_file_location, yml_file.to_yaml)
    end

    def home_dir
      File.join(Dir.pwd)
    end
  end
end
