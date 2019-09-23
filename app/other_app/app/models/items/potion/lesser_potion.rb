module Items
  module Potion
    class LesserPotion
      attr_reader :name, :desc, :heal_min, :heal_max

      def initialize
        @name = 'Lesser Healing Potion'
        @desc = 'A Basic Potion. This vial of liquid "promises" to heal the users injuries a small amount'
        @heal_min = 7
        @heal_max = 11
      end

      def use(player)
        puts 'You open the vial of the potion, and swill the contents with vigour'
        amount = heal_amount

        if heal_to_full?(amount, player)
          puts 'You feel yourself regain full strength!'
          player.hp = player.max_hp
        else
          puts "The potion heals you by #{amount}hp"
          player.hp += amount
        end
      end

      private

      def heal_amount
        rand(heal_min..heal_max)
      end

      def heal_to_full?(amount, player)
        player.hp + amount >= player.max_hp
      end
    end
  end
end
