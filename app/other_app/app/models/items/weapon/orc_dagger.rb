module Items
  module Weapon
    class OrcDagger
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Orc Dagger'
        @desc = 'A tiny dagger concealed by the Orc. What it lacks in size it makes up for in potency.'
        @atk_min = 1
        @atk_max = 6
      end
    end
  end
end
