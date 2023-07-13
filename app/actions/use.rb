# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#use+
    # This will use up the item in your inventory (If it is able to be used). If it cannot
    # be used, an error is thrown. If it can be used, the +use_effect+ from the Model
    # will be passed as a proc and then applied, then it is deleted from your inventory.
    class Use
      attr_reader :hero, :item_id

      include Helpers::Item

      def initialize(hero, item_id)
        @hero = hero
        @item_id = item_id
      end

      # @return [String]
      # This method will use the relevant item (If the item is usable)
      # Once the item has been used, a string representation of the usage is sent
      # to the playing console.
      def use
        Logger.debug("Attempting to use key/potion '#{item_id}'")
        return Screen.output("You do not have a #{item_id}".red) unless in_inventory?
        return Screen.output('You cannot use this item!'.red) unless potion? || key?
        return drink_potion if potion?

        use_key
      end

      private

      def drink_potion
        dump_hp_mp_stats
        potion.use
        remove_one_copy_from_inventory
      end

      def use_key
        key.use
        remove_one_copy_from_inventory
      end

      def potion?
        potion.type != :unknown
      end

      def potion
        @potion ||= Potion.of_type(item_id)
      end

      def dump_hp_mp_stats
        Logger.debug("Previous hp #{@hero.hp}. Previous mp #{@hero.mp}")
      end

      def key?
        !key.name.nil?
      rescue RuntimeError
        false
      end

      def key
        @key ||= Key.of_type(item_id)
      end

      def in_inventory?
        hero.inventory.include?(item_id)
      end

      def remove_one_copy_from_inventory
        hero.inventory.delete_at(index_of_first_copy)
      end

      def index_of_first_copy
        hero.inventory.index(item_id)
      end
    end
  end
end
