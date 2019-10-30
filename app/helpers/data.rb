# frozen_string_literal: true

module MUD
  module Helpers
    # Package Private Helpers to load the various data files up
    # Used to fetch values and data about almost anything in the game
    module Data
      def player
        MUD::Game.player
      end
      
      private

      def description_yml
        load_yml('data/rooms/description.yml')
      end

      def direction_yml
        load_yml('data/rooms/direction.yml')
      end

      def enemy_yml
        load_yml('data/enemies/enemy.yml')
      end

      def boss_yml
        load_yml('data/enemies/boss.yml')
      end

      def weapon_yml
        load_yml('data/items/weapon.yml')
      end

      def healing_potion_yml
        load_yml('data/items/potions/healing.yml')
      end

      def hp_bonus_potion_yml
        load_yml('data/items/potions/hp_bonus.yml')
      end

      def mana_potion_yml
        load_yml('data/items/potions/mana.yml')
      end

      def armor_yml
        load_yml('data/items/armor.yml')
      end

      def load_yml(file_subdir)
        YAML.load_file("#{Dir.pwd}/#{file_subdir}")
      end
    end
  end
end
