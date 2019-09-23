module Items
  module Weapon
    class Fists
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Fists'
        @desc = 'Fighting with your fists. Not much use when it comes to fighting someone with a sword!'
        @atk_min = 0
        @atk_max = 1
      end
    end
  end
end
