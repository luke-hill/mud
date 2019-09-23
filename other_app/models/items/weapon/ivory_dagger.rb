module Items
  module Weapon
    class IvoryDagger
      attr_reader :name, :desc, :atk_min, :atk_max

      def initialize
        @name = 'Ivory Dagger'
        @desc = description
        @atk_min = 5
        @atk_max = 8
      end

      private

      def description
        'The flecks of gold engraved into the hilt disguise the fact that this weapon is the favoured amongst\
         the Bandits of the Forest Path. The Ivory in this weapon came from the Woolly Mammoths of QuestArea1'
      end
    end
  end
end
