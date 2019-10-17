module MUD
  module Classes
    class Fighter < Base
      def initialize
        @attributes = starting_attributes
        super
      end

      def equip(item_id)
        MUD::Logger.debug("Looking for #{item_id}.")
        new_item_id = find(item_id, types: %w[weapon armor])
        return MUD::Screen.output('You do not have this item to equip.') unless new_item_id

        current_weapon_id = equipment[:weapon]
        inventory << current_weapon_id
        equipment[:weapon] = new_item_id
        remove_from_inventory(new_item_id)
      end

      def find(item_id, types = nil)
        if types
          inventory.collect { |item| types.include?(item.type) }
        else
          inventory
        end.detect do |item|
          item.id == item_id
        end
      end

      def remove_from_inventory(item_id)
        MUD::Logger.debug("Looking for #{item_id}.")
        item = find(item_id)
        return MUD::Screen.output('You do not have this item to remove.') unless item

        removed_item = inventory.delete_at(inventory.index(item))
        MUD::Screen.output("Removed #{removed_item}")
      end

      private

      def starting_attributes
        {
          name: 'Test Player',
          max_hp: 25,
          hp: 25,
          stamina: 1,
          level: 1,
          experience: 0,
          gold: 200,
          inventory: []
        }
      end
    end
  end
end
