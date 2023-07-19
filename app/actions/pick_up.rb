# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#pick_up+
    # This will make a series of checks which will determine if you are allowed to pick up the +item_id+
    # that is passed in on initialization of the class. If all checks pass. It will pick up the item
    # adding a copy to your inventory, and then remove the item from the floor
    class PickUp
      attr_reader :item_id

      include Helpers::Item
      include Helpers::Methods
      extend Forwardable

      def initialize(item_id)
        @item_id = item_id
      end

      def_delegators \
        :player,
        :current_room,
        :inventory,
        :max_inventory_size

      # @return [String]
      # This method will pick up the relevant item (If they pass the checks). Once the item has been
      # picked up, a string representation of the action is sent to the playing console.
      def pick_up
        return Screen.output("I'm sorry that item isn't on the floor".red) unless on_floor?
        return Screen.output('You do not have enough space for that.'.red) unless enough_space?

        pick_up_item
      end

      private

      def enough_space?
        inventory.compact.length < max_inventory_size
      end

      def on_floor?
        floor.include?(item_id)
      end

      def floor
        current_room.floor
      end

      def pick_up_item
        inventory << item_id
        remove_item_from_floor
        Screen.output("You picked up a #{item_id.blue}.")
      end

      def remove_item_from_floor
        Logger.debug("Looking for #{item_id}.")
        item = find_item
        return Screen.output('You do not have this item to remove.') unless item

        removed_item = floor.delete_at(floor.index(item))
        Logger.info("Removed #{removed_item} from floor.")
      end

      def find_item
        floor.detect do |item|
          item == item_id
        end
      end
    end
  end
end
