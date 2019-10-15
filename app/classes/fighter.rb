module MUD
  module Classes
    class Fighter
      attr_reader :attributes
      private :attributes

      attr_accessor :current_room, :rooms_visited

      # These are all the accessors for the individual attributes which allow
      # us to read and write to them whilst also logging our requests for
      # maximum traceability
      include MUD::Helpers::AttributeAccessors

      def initialize
        @attributes = starting_attributes
        @current_room = MUD::Rooms::Room.new(starting_room)
        set_rooms_visited_to_blank
        @equipment = starting_equipment
      end

      def connected_rooms
        current_room.connected_rooms
      end

      def move(direction)
        Logger.debug("Attempting to move #{direction}")
        MUD::Movement::Move.send(direction)
      end

      def equip(weapon_id)
        MUD::Logger.debug("Looking for #{weapon_id}.")

        weapon = find(weapon_id)

        return MUD::Screen.output('You do not have this item to equip.') unless weapon
        
        # if yes, then take the currently equipped weapon and put it in my inventory
        # then take my inventory weapon and equip it.
        # then delete the weapon from my inventory
      end

      def find(item_id)
        inventory.detect { |item| item.id == item_id }
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

      def starting_equipment
        {
          weapon: 'fists',
          armor: 'unarmored'
        }
      end

      def starting_room
        1
      end

      def set_rooms_visited_to_blank
        @rooms_visited ||= {}
      end
    end
  end
end
