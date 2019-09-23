module Items
  module Armor
    class Cloak
      attr_reader :name, :desc, :def

      def initialize
        @name = 'Cloak'
        @desc = 'A Blue Cloak that has been discarded by a mage. It provides a basic level of defensive cover'
        @def = 4
      end
    end
  end
end
