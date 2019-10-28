# frozen_string_literal: true

module MUD
  module Room
    class EnemyDrops
      def goblin_drop
        weapon_drop
        gold_drop
      end

      def orc_drop
        armor_drop
        gold_drop
      end

      def gold_drop
        amount = rand(10)
        if amount > 0 #90%
          puts "You found #{pluralize(amount, 'gold coin')} on the corpse of the #{enemy_name}"
          floor << Items::Gold.new(amount)
        end
      end

      def weapon_drop
        floor << enemy_weapon
      end

      def armor_drop
        if rand(100) < 8 #8%
          floor << enemy_armor
          puts "The #{enemy_name} dropped its #{armor_name}"
        end
      end
    end
  end
end
