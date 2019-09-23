module Items
  module Armor
    class Vest
      attr_reader :name, :desc, :def

      def initialize
        @name = 'Vest'
        @desc = 'An Airy vest that lets you enjoy the sun, but offers nothing in the way of protection'
        @def = 1
      end
    end
  end
end
