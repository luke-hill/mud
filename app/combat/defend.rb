module MUD
  module Combat
    class Defend
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      def debug
        MUD::Logger.debug("Hero #{hero.inspect}")
        MUD::Logger.debug("Enemy #{enemy.inspect}")
      end

      def defend
        damage_taken
        new_hp_after_taking_hit
      end

      private

      def damage_taken
        dmg = enemy_attack_value - hero_defence_value

        if dmg.negative?
          0
        else
          dmg
        end
      end

      def enemy_attack_value
        enemy.attack_value
      end

      def hero_defence_value
        rand(0..(hero.armor.def))
      end

      def new_hp_after_taking_hit
        if enemy_missed? || @dmg_taken.zero?
          return MUD::Screen.output("The #{enemy_name} swung at you with his #{enemy_weapon_name}, but missed.")
        end

        MUD::Screen.output("The #{enemy_name} hit you for #{@dmg_taken} damage.")
        update_hero_hp

        if dead?
          raise StandardError, 'You died!'
        else
          MUD::Logger.debug("DEBUG --> YOUR HP:#{hp}hp.")
        end
      end

      def enemy_missed?
        rand > enemy.accuracy
      end

      def enemy_name
        enemy.name
      end

      def enemy_weapon_name
        enemy.weapon.name
      end

      def enemy_hp
        enemy.hp
      end

      def update_hero_hp
        hero.hp -= @dmg_taken
        hero.prevent_negative_hp
      end

      def dead?
        hero.hp <= 0
      end
    end
  end
end
