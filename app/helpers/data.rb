# frozen_string_literal: true

module MUD
  module Helpers
    # Package Private Helpers to load the various data files up
    # Used to fetch values and data about almost anything in the game
    module Data
      # @return [MUD::Classes::Fighter]
      # The active player inside the game
      def player
        MUD::Game.player
      end

      private

      def description_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/rooms/description.yml")
      end

      def direction_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/rooms/direction.yml")
      end

      def shop_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/rooms/shop.yml")
      end

      def enemy_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/enemies/enemy.yml")
      end

      def boss_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/enemies/boss.yml")
      end

      def weapon_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/weapon.yml")
      end

      def healing_potion_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/potions/healing.yml")
      end

      def hp_bonus_potion_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/potions/hp_bonus.yml")
      end

      def mana_potion_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/potions/mana.yml")
      end

      def armor_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/armor.yml")
      end

      def key_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/items/key.yml")
      end

      def xp_yml
        load_yml("#{ENV.fetch('DATA_SOURCE')}/players/xp.yml")
      end

      def load_yml(file_subdir)
        YAML.load_file("#{Dir.pwd}/#{file_subdir}", symbolize_names: false)
      end
    end
  end
end
