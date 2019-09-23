module Items
  module Weapon
    class RustySword
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Rusty Sword'
        @desc = "A silver sword. Though basic by design, it looks as though it's rusted up due to lack of use"
        @atk_min = 2
        @atk_max = 4
      end
    end
  end
end
