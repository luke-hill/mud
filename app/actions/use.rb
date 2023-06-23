# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#use+
    # This will use up the item in your inventory (If it is able to be used). If it cannot
    # be used, an error is thrown. If it can be used, the +use_effect+ from the Model
    # will be passed as a proc and then applied, then it is deleted from your inventory.
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
        :hp=,
        :mp=,
        :max_hp=

      # @return [String]
      # This method will use the relevant item (If the item is usable)
      # Once the item has been used, a string representation of the usage is sent
      # to the playing console.
      def use
        return MUD::Screen.output("You do not have a #{item_id}".red) unless in_inventory?
        return MUD::Screen.output('You cannot use this item!'.red) unless potion? || key?

        if potion?
          dump_hp_mp_stats
          potion.use
        else
          MUD::Screen.output(key.use_message.yellow)
        end

        remove_one_copy_from_inventory
      end

      private

      def potion?
        potion.type != :unknown
      end

      def potion
        @potion ||= MUD::Potion.new(item_id)
      end

      def dump_hp_mp_stats
        MUD::Logger.debug("Previous hp #{@hero.hp}. Previous mp #{@hero.mp}")
      end

      def key?
        !key.name.nil?
      rescue RuntimeError
        false
      end

      def key
        @key ||= MUD::Key.new(item_id)
      end

      def in_inventory?
        inventory.include?(item_id)
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
