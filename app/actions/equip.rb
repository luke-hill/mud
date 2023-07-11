# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#equip+
    # This will make a series of checks which will determine if you are allowed to equip
    # the +item_id+ that is passed in on initialization of the class. If all checks pass.
    # It will then equip the item in either your weapon or armor slot. Any previously
    # equipped items in the slot will then be passed back into your inventory.
    class Equip
      attr_reader :item_id

      include Helpers::Item
      extend Forwardable

      def initialize(hero, item_id)
        @hero = hero
        @item_id = item_id
      end

      # @return [String]
      # This method will equip the relevant item (If they pass the checks). Once the item has been
      # equipped, the existing item is switched with the item in their inventory.
      # The player is then informed via the playing console of the switch of items.
      def equip
        Logger.debug("Attempting to equip #{item_id}")
        validate_presence
        MUD::Logger.debug("Looking for #{item_id}.")
        equip_weapon if weapon?
        equip_armor if armor?
        MUD::Screen.output("#{item_id} equipped.")
      end

      def_delegators \
        :@hero,
        :inventory,
        :equipment

      private

      def equip_weapon
        new_weapon_id = find(item_id, %w[weapon])
        return MUD::Screen.output('You do not have this weapon to equip.') unless new_weapon_id

        current_weapon_id = equipment[:weapon]
        inventory << current_weapon_id
        equipment[:weapon] = new_weapon_id
        remove_from_inventory(new_weapon_id)
      end

      def equip_armor
        new_armor_id = find(item_id, %w[armor])
        return MUD::Screen.output('You do not have this armor to equip.') unless new_armor_id

        current_armor_id = equipment[:armor]
        inventory << current_armor_id
        equipment[:armor] = new_armor_id
        remove_from_inventory(new_armor_id)
      end

      def remove_from_inventory(item_id)
        MUD::Logger.debug("Looking for #{item_id}.")
        item = find(item_id)
        return MUD::Screen.output('You do not have this item to remove.') unless item

        removed_item = inventory.delete_at(inventory.index(item))
        MUD::Screen.output("Removed #{removed_item}")
      end

      def find(item_id, types = [])
        items_of_type(types).detect do |item|
          item == item_id
        end
      end

      def items_of_type(types)
        if types.any?
          inventory.select { |item| item_ids(types).include?(item) }
        else
          inventory
        end
      end

      def item_ids(types)
        types.map { |type| send("#{type}_ids") }.flatten
      end

      def weapon?
        item_type == :weapon
      end

      def armor?
        item_type == :armor
      end

      def in_inventory?
        inventory.include?(item_id)
      end

      def validate_presence
        return if in_inventory?

        MUD::Logger.error("An error has occurred trying to find #{item_id} in inventory")
        raise(ArgumentError, "You do not have a #{item_id} in your inventory.")
      end

      def item_type
        return :weapon if weapon_ids.include?(item_id)
        return :armor if armor_ids.include?(item_id)

        MUD::Logger.error("An error has occurred trying to classify the type of #{item_id}")
        raise(ArgumentError, "Cannot classify #{item_id}.")
      end
    end
  end
end
