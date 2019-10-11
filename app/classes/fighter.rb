module MUD
  module Classes
    class Fighter
      attr_reader :attributes
      private :attributes

      attr_accessor :current_room

      include MUD::Helpers::AttributeAccessors

      def initialize
        @attributes = starting_attributes
        @current_room = MUD::Rooms::Room.new(starting_room)
      end

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

      def connected_rooms
        current_room.connected_rooms
      end

      def move(direction)
        Logger.debug("Attempting to move #{direction}")
        MUD::Movement::Move.send(direction)
      end

      private

      def starting_room
        1
      end
    end
  end
end
