module Items
  module Armor
    class OrcHide
      attr_reader :name, :desc, :def

      def initialize
        @name = 'Orc Hide'
        @desc = 'Though primitive in design, these interlocking scales form a sturdy barrier against attack'
        @def = 8
      end
    end
  end
end
