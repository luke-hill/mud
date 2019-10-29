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
        drop_gold
      end

      private

      def drop_potion
        return unless potion_drop?

        floor << enemy.dropped_potion_id
        MUD::Screen.output(enemy.dropped_potion_message.yellow)
      end

      def potion_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop potion #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_potion_chance}")
        chance < enemy.dropped_potion_chance
      end

      def drop_weapon
        return unless weapon_drop?

        floor << enemy.dropped_weapon_id
        MUD::Screen.output(enemy.dropped_weapon_message.yellow)
      end

      def weapon_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop weapon #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_weapon_chance}")
        chance < enemy.dropped_weapon_chance
      end

      def drop_armor
        return unless armor_drop?

        floor << enemy.dropped_armor_id
        MUD::Screen.output(enemy.dropped_armor_message.yellow)
      end

      def armor_drop?
        chance = rand
        MUD::Logger.debug("Random chance to drop armor #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_armor_chance}")
        chance < enemy.dropped_armor_chance
      end

      def drop_gold
        MUD::Screen.output("You found #{gold_amount} on the corpse of the #{enemy.name}")
      end

      def gold_amount
        pluralize(enemy.gold, 'gold coin')
      end

      def floor
        hero.current_room.floor
      end
    end
  end
end
