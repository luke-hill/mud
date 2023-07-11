# frozen_string_literal: true

require 'yaml'
require 'active_support/all'

module AdminPanel
  # Seed the Database using input from either an individual file or from a rake invocation
  #
  # Usage is:
  # 1) Call rake to +seed_all_versions+
  # 2)i) Rake in turn will call individual folders which represent a version of the game
  # 2)ii) Each folder will then recursively require each file
  # 2)iii) Each file will seed a small amount of data to the database
  # 3) Once Rake has seeded an entire file, and then an entire folder, it moves on to the next one
  # 4) Once Rake has seeded every folder, the procedure is finished
  class Seeder
    class << self
      # @return [String]
      # Seed all versions that exist in /updates directory
      # Returns updates after each seed iteration
      def seed_all_versions
        current_seed_files.each { |file| require file }
      end

      private

      def current_seed_files
        Dir[File.absolute_path('./admin_panel/updates/**/*.rb')]
      end
    end

    attr_reader :type
    attr_accessor :options

    def initialize(type)
      @type = type
    end

    # @return [String]
    # Seed an individual data point into a specific folder based on +type+ input
    # Returns the old/new data-points as an update during seed process
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
      equipment_yamls
        .merge(enemy_yamls)
        .merge(room_yamls)
        .merge(item_yamls)
        .merge(player_yamls)
    end

    def equipment_yamls
      {
        armor: "#{Dir.pwd}/data/items/armor.yml",
        weapon: "#{Dir.pwd}/data/items/weapon.yml"
      }
    end

    def enemy_yamls
      {
        boss: "#{Dir.pwd}/data/enemies/boss.yml",
        enemy: "#{Dir.pwd}/data/enemies/enemy.yml"
      }
    end

    def room_yamls
      {
        description: "#{Dir.pwd}/data/rooms/description.yml",
        direction: "#{Dir.pwd}/data/rooms/direction.yml",
        location: "#{Dir.pwd}/data/rooms/location.yml",
        shop: "#{Dir.pwd}/data/rooms/shop.yml"
      }
    end

    def item_yamls
      {
        healing_potion: "#{Dir.pwd}/data/items/potions/healing.yml",
        hp_bonus_potion: "#{Dir.pwd}/data/items/potions/hp_bonus.yml",
        key: "#{Dir.pwd}/data/items/key.yml",
        mana_potion: "#{Dir.pwd}/data/items/potions/mana.yml"
      }
    end

    def player_yamls
      {
        xp: "#{Dir.pwd}/data/players/xp.yml"
      }
    end

    def full_values
      yml_file.merge(new_values)
    end

    def yml_file
      YAML.load_file(yml_file_location)
    rescue Errno::ENOENT
      puts "File does not exist @ #{yml_file_location}. Creating new blank YML file."
      File.write(yml_file_location, {})
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
  end
end
