# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#buy+
    # This will make a series of checks which will determine if you are allowed to buy the +item_id+
    # that is passed in on initialization of the class. If all checks pass. It will deduct the cost
    # of the item from your gold, and then add a copy to your inventory
    class Buy
      attr_reader :item_id

      include Helpers::Item
      extend Forwardable

      def initialize(hero, item_id, room)
        @hero = hero
        @item_id = item_id
        @room = room
      end

      def_delegators \
        :@hero,
        :inventory,
        :gold,
        :gold=,
        :max_inventory_size

      # @return [String]
      # This method will buy the relevant item (If they pass the checks). Once the item has been
      # bought, a string representation of the transaction is sent to the playing console.
      def buy
        return MUD::Screen.output("I'm sorry we dont have that item for sale".red) unless for_sale?
        return MUD::Screen.output('You do not have enough gold for that.'.red) unless enough_money?
        return MUD::Screen.output('You do not have enough space for that.'.red) unless enough_space?

        buy_item
      end

      private

      def cost
        # We need a new database seeding of shop locations with items!
        # Lesser Healing Pots are 25 and Heal for 10 (That is it currently!)
        25
      end

      def enough_money?
        MUD::Logger.debug("Current gold amount #{gold}")
        gold >= cost
      end

      def enough_space?
        inventory.compact.length < max_inventory_size
      end

      def for_sale?
        # We need the concept of what items are for sale where
        # For now this will be true for the 1 shop
        true
      end

      def buy_item
        self.gold -= cost
        inventory << item_id
        MUD::Screen.output("You bought a #{item_id.blue} for #{cost.to_s.yellow} gold.")
      end
    end
  end
end
