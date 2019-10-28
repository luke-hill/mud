# frozen_string_literal: true

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

      def look_around
        MUD::Screen.output(player.current_room.advanced_description)
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

      def dead?
        !alive?
      end

      def move(direction)
        Logger.debug("Attempting to move #{direction}")
        MUD::Actions::Move.send(direction)
      end

      def prevent_negative_hp
        self.hp = 0 if hp.negative?
      end

      def equip(item_id)
        Logger.debug("Attempting to equip #{item_id}")
        MUD::Actions::Equip.new(self, item_id).equip
      end

      def weapon
        equipment[:weapon]
      end

      def armor
        equipment[:armor]
      end

      private

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

      def attribute_names
        %i[name max_hp hp level stamina experience gold inventory accuracy]
      end
    end
  end
end
