module Items
  module Armor
    class DrazGhunsFleece
      attr_reader :name, :desc, :def

      def initialize
        @name = "Draz'Ghun's Fleece"
        @desc = 'This fleece, straight out of his shop in LevelOne, is said to be the perfect accompaniment to a travelling warrior'
        @def = 5
      end
    end
  end
end
