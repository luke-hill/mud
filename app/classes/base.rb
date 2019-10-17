module MUD
  module Classes
    class Base
      attr_reader :attributes, :equipment
      private :attributes, :equipment

      attr_accessor :current_room, :rooms_visited

      # These are all the accessors for the individual attributes which allow
      # us to read and write to them whilst also logging our requests for
      # maximum traceability
      include MUD::Helpers::AttributeAccessors

      def initialize
        @attributes = starting_attributes
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

      def connected_rooms
        current_room.connected_rooms
      end

      def prevent_negative_hp
        self.hp = 0 if hp.negative?
      end

      private

      def starting_equipment
        {
          weapon: 'fists',
          armor: 'unarmored'
        }
      end

      def starting_room
        MUD::Room.new(starting_room_id)
      end

      def starting_room_id
        1
      end

      def set_rooms_visited_to_blank
        @rooms_visited ||= {}
      end

      def attribute_names
        %i[name max_hp hp level stamina experience gold inventory]
      end
    end
  end
end
