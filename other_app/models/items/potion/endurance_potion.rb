module Items
  module Potion
    class EndurancePotion
      attr_reader :name, :desc, :hp_bonus

      def initialize
        @name = 'Endurance Potion'
        @desc = potion_description
        @hp_bonus = 1
      end

      def use(player)
        puts used_a_potion_message
        player.max_hp += hp_bonus
      end

      private

      def potion_description
        'This flask contains a potion with a green hue, it is rumoured to increase the damage you can take before dying'
      end

      def used_a_potion_message
        "You consume the potion, and feel enhanced almost immediately. Your maximum hp has increased by #{hp_bonus}"
      end
    end
  end
end
