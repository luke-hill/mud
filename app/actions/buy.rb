# frozen_string_literal: true

module MUD
  module Actions
    class Buy
      attr_reader :item_id

      include Helpers::Item
      extend Forwardable

      def initialize(hero, item_id)
        @hero = hero
        @item_id = item_id
      end

      def buy(item_id)
        if for_sale?(item_id)
          if enough_money?(item_id)
            if enough_space?
              player.gold -= cost(item_id)
              player.inventory << item_id
            end

            MUD::Screen.output("You bought a #{item_id.blue} for #{cost(item_id).yellow} gold.")
          else
            MUD::Screen.output('You do not have enough gold for that.'.red)
          end
        else
          MUD::Screen.output("I'm sorry we dont have that item for sale")
        end
      end

      private

      def cost(item_id)
        # We need a new database seeding of shop locations with items!
        # Lesser Healing Pots are 25 and Heal for 10 (That is it currently!)
        25
      end

      def enough_money?(item_id)
        MUD::Logger.debug("Current gold amount #{player.gold}")
        player.gold >= cost(item_id)
      end

      def enough_space?
        player.inventory.compact.length < player.max_inventory_size
      end

      def for_sale?(item_id)
        # We need the concept of what items are for sale where
        # For now this will be true for the 1 shop
        true
      end
    end
  end
end
