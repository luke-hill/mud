module Items
  module Armor
    class OrcShield
      attr_reader :name, :desc, :def

      def initialize
        @name = 'Orc Shield'
        @desc = 'This shield is fashioned from the bones of its last few victims. It is covered in spikes that offer some basic protection.'
        @def = 2
      end
    end
  end
end
