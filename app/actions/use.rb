# frozen_string_literal: true

module MUD
  module Actions
    # The Use Action
    # Like the other ones, this provides a single public method +#use+
    # This will use up the item in your inventory (If it is able to be used).
    #
    # If it cannot be used, an error is thrown.
    # If it can be used, the use_effect from the Model will be passed as a proc and then
    # applied to the hero or wherever relevant.
    #
    # Once the item is used, a single copy is deleted from your inventory.
    class Use
      attr_reader :item_id

      include Helpers::Item
      extend Forwardable

      def initialize(hero, item_id)
        @hero = hero
        @item_id = item_id
      end

      def_delegators \
        :@hero,
        :inventory,

      def use
        return MUD::Screen.output("You cannot use this item!".red) unless usable?

        MUD::Logger.debug("Previous hp #{hero.hp}. Previous mp #{hero&.mp}")
        potion.use_effect.call
        MUD::Screen.output("#{item_id.use_message} #{item_id.value}".yellow)
      end

      private

      def usable?
        MUD::Logger.debug("Ascertaining whether the item can be 'used'")
        # For now we will only check it's a potion. There will also be key consumables later
        potion?
      end

      def potion?
        potion.type != :unknown
      end

      def potion
        @potion ||= MUD::Potion.new(item_id)
      end

      def remove_one_copy_from_inventory
        inventory.delete_at(index_of_first_copy)
      end

      def index_of_first_copy
        inventory.index(item_id)
      end
    end
  end
end
