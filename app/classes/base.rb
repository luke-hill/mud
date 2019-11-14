# frozen_string_literal: true

module MUD
  module Classes
    # The Base class
    # All other classes inherit from this. Here we provide the classes with their
    # base functionality. Things such as viewing attributes, looking around, as well as
    # some basic boolean checks are defined. There are also wrapper calls to each of the
    # Actions Classes allowing all Heroes to Move or Equip items.
    class Base
      attr_reader :attributes, :equipment
      private :attributes, :equipment

      attr_accessor :current_room, :rooms_visited

      # These are all the accessors for the individual attributes which allow
      # us to read and write to them whilst also logging our requests for
      # maximum traceability
      include MUD::Helpers::AttributeAccessors
      include Helpers::Item
      include Helpers::Data

      def initialize
        @current_room = starting_room
        @equipment = starting_equipment
        @rooms_visited = starting_rooms_visited
      end

      def look_around
        MUD::Screen.output(current_room.advanced_description)
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
        MUD::Actions::Move.new(self, direction).move
      end

      def prevent_negative_hp
        self.hp = 0 if hp.negative?
      end

      def prevent_overflow_hp
        self.hp = max_hp if hp > max_hp
      end

      def prevent_negative_mp
        self.mp = 0 if mp.negative?
      end

      def prevent_overflow_mp
        self.mp = max_mp if mp > max_mp
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

      def use(item_id)
        Logger.debug("Attempting to use key/potion '#{item_id}'")
        MUD::Actions::Use.new(self, item_id).use
      end

      def capped?
        # For now this is false - Until we get the full seeded model introduced
        return false

        xp >= xp_for_next_level['cap']
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

      def starting_rooms_visited
        {}
      end

      def attribute_names
        MUD::Helpers::AttributeAccessors.attribute_names
      end

      def xp_for_next_level
        xp_yml[level]
      end
    end
  end
end
