# frozen_string_literal: true

module MUD
  module Combat
    class ItemDrops
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      def process
        drop_potion
        drop_weapon
        drop_armor
      end

      private

      def drop_potion
        floor << enemy.dropped_potion_id if potion_drop?
      end

      def potion_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop potion #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_potion_chance}")
        chance < enemy.dropped_potion_chance
      end

      def drop_weapon
        floor << enemy.dropped_weapon_id if weapon_drop?
      end

      def weapon_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop weapon #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_weapon_chance}")
        chance < enemy.dropped_weapon_chance
      end

      def drop_armor
        floor << enemy.dropped_armor_id if armor_drop?
      end

      def armor_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop armor #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_armor_chance}")
        chance < enemy.dropped_armor_chance
      end
    end
  end
end
