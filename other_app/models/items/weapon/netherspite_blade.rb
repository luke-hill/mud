module Items
  module Weapon
    class NetherspiteBlade
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Netherspite Blade'
        @desc = 'Aged and worn from battles gone by, you can just make out a slight purple hue from the hilt'
        @atk_min = 3
        @atk_max = 10
      end
    end
  end
end
