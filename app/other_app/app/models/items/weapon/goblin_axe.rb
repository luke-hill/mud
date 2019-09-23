module Items
  module Weapon
    class GoblinAxe
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Goblin Axe'
        @desc = 'A primitive axe fashioned out of a branch and a piece of old flint, tied together with a single orc hair'
        @atk_min = 1
        @atk_max = 3
      end
    end
  end
end
