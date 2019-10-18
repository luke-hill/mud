module MUD
  module Classes
    class Base
      attr_reader :attributes, :equipment
      private :attributes

      attr_accessor :current_room, :rooms_visited

      # These are all the accessors for the individual attributes which allow
      # us to read and write to them whilst also logging our requests for
      # maximum traceability
      include MUD::Helpers::AttributeAccessors
      include Helpers::Item

      def initialize
        @current_room = starting_room
        @equipment = starting_equipment
        set_rooms_visited_to_blank
      end

      def view_attributes
        attribute_names.each do |attribute|
          MUD::Logger.debug('Call made to view attributes')
          MUD::Screen.output("#{attribute}: #{attributes[attribute]}".yellow)
        end
      end

      def alive?
        hp.positive?
      end

      def move(direction)
        Logger.debug("Attempting to move #{direction}")
        MUD::Movement::Move.send(direction)
      end

      def prevent_negative_hp
        self.hp = 0 if hp.negative?
      end

      def equip(item_id)
        MUD::Logger.debug("Looking for #{item_id}.")
        equip_weapon(item_id) if weapon?(item_id)
        equip_armor(item_id) if armor?(item_id)
        MUD::Screen.output("#{item_id} equipped")
      end

      private

      def weapon?(item_id)
        type_of(item_id) == :weapon
      end

      def armor?(item_id)
        type_of(item_id) == :armor
      end

      def type_of(item_id)
        return :weapon if weapon_ids.include?(item_id)
        return :armor if armor_ids.include?(item_id)
        MUD::Logger.error("An error has occurred trying to classify the type of #{item_id}")
        raise "Cannot classify #{item_id}."
      end

      def equip_weapon(item_id)
        new_weapon_id = find(item_id, %w[weapon])
        return MUD::Screen.output('You do not have this weapon to equip.') unless new_weapon_id

        current_weapon_id = equipment[:weapon]
        inventory << current_weapon_id
        equipment[:weapon] = new_weapon_id
        remove_from_inventory(new_weapon_id)
      end

      def equip_armor(item_id)
        new_armor_id = find(item_id, %w[armor])
        return MUD::Screen.output('You do not have this armor to equip.') unless new_armor_id

        current_armor_id = equipment[:armor]
        inventory << current_armor_id
        equipment[:armor] = new_armor_id
        remove_from_inventory(new_armor_id)
      end

      def starting_room
        MUD::Room.new(starting_room_id)
      end

      def starting_room_id
        1
      end

      def starting_equipment
        {
          weapon: 'fists',
          armor: 'unarmored'
        }
      end

      def set_rooms_visited_to_blank
        @rooms_visited ||= {}
      end

      def remove_from_inventory(item_id)
        MUD::Logger.debug("Looking for #{item_id}.")
        item = find(item_id)
        return MUD::Screen.output('You do not have this item to remove.') unless item

        removed_item = inventory.delete_at(inventory.index(item))
        MUD::Screen.output("Removed #{removed_item}")
      end

      def attribute_names
        %i[name max_hp hp level stamina experience gold inventory]
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
    end
  end
end
