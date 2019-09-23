module Items
  module Weapon
    class Knife
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Knife'
        @desc = 'A primitive knife used by huntsmen'
        @atk_min = 1
        @atk_max = 2
      end
    end
  end
end
