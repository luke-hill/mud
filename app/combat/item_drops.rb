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
      attr_reader :enemy

      include Helpers::Methods

      def initialize(enemy)
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
        return Logger.debug("Enemy didn't drop potion") unless yield_potion?

        drop_location << enemy.dropped_potion_id
        Screen.output(enemy.dropped_potion_message.yellow)
      end

      def yield_potion?
        chance = rand
        Logger.debug("Random chance to drop potion #{chance}")
        Logger.debug("Chance needed #{enemy.dropped_potion_chance}")
        chance < enemy.dropped_potion_chance
      end

      def yield_weapon
        return Logger.debug("Enemy didn't drop weapon") unless yield_weapon?

        drop_location << enemy.dropped_weapon_id
        Screen.output(enemy.dropped_weapon_message.yellow)
      end

      def yield_weapon?
        chance = rand
        Logger.debug("Random chance to drop weapon #{chance}")
        Logger.debug("Chance needed #{enemy.dropped_weapon_chance}")
        chance < enemy.dropped_weapon_chance
      end

      def yield_armor
        return Logger.debug("Enemy didn't drop armor") unless yield_armor?

        drop_location << enemy.dropped_armor_id
        Screen.output(enemy.dropped_armor_message.yellow)
      end

      def yield_armor?
        chance = rand
        Logger.debug("Random chance to drop armor #{chance}")
        Logger.debug("Chance needed #{enemy.dropped_armor_chance}")
        chance < enemy.dropped_armor_chance
      end

      def yield_gold
        return Logger.debug("Enemy didn't have any gold") unless enemy.gold.positive?

        Screen.output("You found #{gold_amount.yellow} on the corpse of the #{enemy.name}")
        player.gold += enemy.gold
        enemy.gold = 0
      end

      def gold_amount
        "#{enemy.gold} #{'gold coin'.pluralize(enemy.gold)}"
      end

      def drop_location
        if inventory_space_available?
          player.inventory
        else
          floor
        end
      end

      def inventory_space_available?
        player.inventory.length < player.max_inventory_size
      end

      def floor
        player.current_room.floor
      end
    end
  end
end
