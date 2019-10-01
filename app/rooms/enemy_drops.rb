module MUD
  module Room
    class EnemyDrops
      include ::ActionView::Helpers

      attr_reader :enemy

      def initialize(enemy)
        @enemy = enemy
      end

      def drop
        send("#{snake_case(enemy_name)}_drop")
      end

      def floor
        ACTIVE_GAME.player.room.floor
      end

      private

      def goblin_drop
        potion_drops
        weapon_drop
        gold_drop
      end

      def orc_drop
        weapon_drop
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

      def potion_drops
        case rand(100)
        when 0..1 #2%
          2.times do
            floor << Items::Potion::EndurancePotion.new
            puts notify_potion_drop
          end
        when 2..6 #5%
          2.times do
            floor << Items::Potion::LesserPotion.new
            puts notify_potion_drop
          end
        when 7..13 #7%
          floor << Items::Potion::EndurancePotion.new
          floor << Items::Potion::LesserPotion.new
          2.times do
            puts notify_potion_drop
          end
        when 14.30 #17%
          floor << Items::Potion::EndurancePotion.new
          puts notify_potion_drop
        when 31..60 #30%
          floor << Items::Potion::LesserPotion.new
          puts notify_potion_drop
        end
      end

      def weapon_drop
        if rand(100) < 5 #5%
          floor << enemy_weapon
          puts "The #{enemy_name} dropped its #{weapon_name}"
        end
      end

      def snake_case(string)
        string.gsub(' ','_').downcase #TODO: Move to a helper?
      end

      def enemy_name
        enemy.name
      end

      def enemy_weapon
        enemy.weapon
      end

      def weapon_name
        enemy_weapon.name
      end

      def armor_drop
        if rand(100) < 8 #8%
          floor << enemy_armor
          puts "The #{enemy_name} dropped its #{armor_name}"
        end
      end

      def enemy_armor
        enemy.armor
      end

      def armor_name
        enemy_armor.name
      end

      def notify_potion_drop
        'Amongst the corpse of the Goblin, you stumble across a Potion... It falls to the floor, along with its lifeless corpse'
      end
    end
  end
end