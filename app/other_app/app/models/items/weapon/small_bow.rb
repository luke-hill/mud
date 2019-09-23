module Items
  module Weapon
    class SmallBow
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Small Bow'
        @desc = 'This bow is made out of a single, flimsy willow branch. Useful for hunting rabbits and not much more.'
        @atk_min = 3
        @atk_max = 4
      end
    end
  end
end
