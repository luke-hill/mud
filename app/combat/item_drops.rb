# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#process+
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will potentially drop 0-many items from an enemy when it is killed.
    #
    # Which items are dropped and in which circumstances are entirely controlled by the enemy data
    # files found in +data/**/*.yml+
    class ItemDrops
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      # @return [Integer || NilClass]
      # This will drop 1 of each of the following ...
      # potion_id --> If the enemy has a +dropped_potion_id+ property
      # weapon_id --> If the enemy has a +dropped_weapon_id+ property
      # armor_id  --> If the enemy has a +dropped_armor_id+ property
      # gold      --> This will always drop an amount of gold between the min/max values
      def process
        yield_potion if enemy.potion?
        yield_weapon if enemy.weapon?
        yield_armor if enemy.armor?
        yield_gold
      end

      private

      def yield_potion
        return MUD::Logger.debug("Enemy didn't drop potion") unless yield_potion?

        drop_location << enemy.dropped_potion_id
        MUD::Screen.output(enemy.dropped_potion_message.yellow)
      end

      def yield_potion?
        chance = rand
        MUD::Logger.debug("Random chance to drop potion #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_potion_chance}")
        chance < enemy.dropped_potion_chance
      end

      def yield_weapon
        return MUD::Logger.debug("Enemy didn't drop weapon") unless yield_weapon?

        drop_location << enemy.dropped_weapon_id
        MUD::Screen.output(enemy.dropped_weapon_message.yellow)
      end

      def yield_weapon?
        chance = rand
        MUD::Logger.debug("Random chance to drop weapon #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_weapon_chance}")
        chance < enemy.dropped_weapon_chance
      end

      def yield_armor
        return MUD::Logger.debug("Enemy didn't drop armor") unless yield_armor?

        drop_location << enemy.dropped_armor_id
        MUD::Screen.output(enemy.dropped_armor_message.yellow)
      end

      def yield_armor?
        chance = rand
        MUD::Logger.debug("Random chance to drop armor #{chance}")
        MUD::Logger.debug("Chance needed #{enemy.dropped_armor_chance}")
        chance < enemy.dropped_armor_chance
      end

      def yield_gold
        return MUD::Logger.debug("Enemy didn't have any gold") unless enemy.gold.positive?

        MUD::Screen.output("You found #{gold_amount.yellow} on the corpse of the #{enemy.name}")
        hero.gold += enemy.gold
        enemy.gold = 0
      end

      def gold_amount
        "#{enemy.gold} #{'gold coin'.pluralize(enemy.gold)}"
      end

      def drop_location
        if inventory_space_available?
          hero.inventory
        else
          floor
        end
      end

      def inventory_space_available?
        hero.inventory.length < hero.max_inventory_size
      end

      def floor
        hero.current_room.floor
      end
    end
  end
end
