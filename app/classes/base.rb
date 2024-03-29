# frozen_string_literal: true

module MUD
  module Classes
    # The Base class
    # All other classes inherit from this. Here we provide the classes with their
    # base functionality. Things such as viewing attributes, looking around, as well as
    # some basic boolean checks are defined. There are also wrapper calls to each of the
    # Actions Classes allowing Players to move or qquip items
    class Base
      attr_reader :attributes, :equipment

      attr_accessor :current_room, :rooms_visited

      # These are all the accessors for the individual attributes which allow us to read and write to them
      # whilst also logging all our requests for maximum traceability
      include MUD::Helpers::AttributeAccessors
      include Helpers::Data
      include Helpers::Item
      include Helpers::Unabbreviater

      def initialize
        @current_room = starting_room
        @equipment = starting_equipment
        @rooms_visited = {}
      end

      # @return [String]
      # This looks around and returns the advanced description of the current room
      def look_around
        Screen.output(current_room.advanced_description)
      end

      # @return [Array]
      # This returns a newline delimited string which outputs each attribute and its current value
      def view_attributes
        MUD::Helpers::AttributeAccessors.attribute_names.each do |attribute|
          Logger.debug('Call made to view attributes')
          Screen.output("#{attribute}: #{attributes[attribute]}".yellow)
        end
      end

      # @return [Boolean]
      # The current alive status of the player
      def alive?
        hp.positive?
      end

      # @return [Boolean]
      # The current dead status of the player (Opposite of +alive?+)
      def dead?
        !alive?
      end

      # @return [String]
      # The wrapper method call that attempts to move in the direction provided
      def move(direction)
        MUD::Actions::Move.new(direction).move
      end

      # @return [Integer, Nil]
      # A sanitization method preventing hp from ever being negative
      def prevent_negative_hp
        self.hp = 0 if hp.negative?
      end

      # @return [Integer, Nil]
      # A sanitization method preventing hp from ever being too high
      def prevent_overflow_hp
        self.hp = max_hp if hp > max_hp
      end

      # @return [Integer, Nil]
      # A sanitization method preventing mp from ever being negative
      def prevent_negative_mp
        self.mp = 0 if mp.negative?
      end

      # @return [Integer, Nil]
      # A sanitization method preventing mp from ever being too high
      def prevent_overflow_mp
        self.mp = max_mp if mp > max_mp
      end

      # @return [String]
      # This delegates to the Equip class and performs the #equip action
      def equip(item_id)
        MUD::Actions::Equip.new(item_id).equip
      end

      # @return [MUD::Weapon]
      # The currently equipped weapon
      def weapon
        equipment[:weapon]
      end

      # @return [MUD::Armor]
      # The currently equipped armor
      def armor
        equipment[:armor]
      end

      # @return [String]
      # This delegates to the Use class and performs the #use action
      def use(item_id)
        MUD::Actions::Use.new(item_id).use
      end

      # @return [String]
      # This delegates to the Fight class and performs the #fight action
      def fight(times = 1)
        MUD::Combat::Fight.new(current_room.enemy).fight(times)
      end

      # @return [Boolean]
      # The current capped status of the player (Whether they are able to earn any more experience)
      def capped?
        experience >= xp_for_next_level['cap']
      end

      # @return [Float]
      # Player accuracy rating - this equates to ...
      #
      # 5 - Worst agility (Magic users)
      # Level 1 - 27%
      # Level 5 - 43%
      # Level 10 - 54%
      # Level 11 - 56%
      #
      # 7 - Medium agility (Physical attackers)
      # Level 1 - 27%
      # Level 5 - 51%
      # Level 10 - 63%
      # Level 11 - 65%
      #
      # 10 - Max agility (Nimble attackers)
      # Level 1 - 27%
      # Level 5 - 67%
      # Level 10 - 81%
      # Level 11 - 83%
      def accuracy
        base_accuracy + accuracy_level_bonus + agility_accuracy_bonus
      end

      private

      def starting_room
        MUD::Room.new(1)
      end

      def starting_equipment
        {
          weapon: Weapon.of_type('fists'),
          armor: Armor.of_type('unarmored')
        }
      end

      def xp_for_next_level
        xp_yml[level]
      end

      def base_accuracy
        0.25
      end

      def accuracy_level_bonus
        0.02 * level
      end

      def agility_accuracy_bonus
        (agility * 0.02 * decrementing_agility_multiplier)
      end

      def decrementing_agility_multiplier
        (agility.to_f * (level - 1)) / (5 * level.to_f)
      end
    end
  end
end
