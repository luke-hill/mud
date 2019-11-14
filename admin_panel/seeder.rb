# frozen_string_literal: true

require 'yaml'
require 'active_support/all'

module AdminPanel
  class Seeder
    class << self
      def seed_all_versions
        current_seed_files.each(&method(:require))
      end

      private

      def current_seed_files
        Dir[File.absolute_path('./admin_panel/updates/**/*.rb')].sort
      end
    end

    attr_reader :type
    attr_accessor :options

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
        location: "#{Dir.pwd}/data/rooms/location.yml"
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
      File.open(yml_file_location, 'w+') { |f| f.write({}) }
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
