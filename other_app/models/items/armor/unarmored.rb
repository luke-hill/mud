module Items
  module Armor
    class Unarmored
      attr_reader :name, :desc, :def

      def initialize
        @name = 'Unarmored'
        @desc = 'Just skin and bones! nothing that will stop an enemies strike'
        @def = 0
      end
    end
  end
end
