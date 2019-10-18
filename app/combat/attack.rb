module MUD
  module Combat
    class Attack
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      def debug
        MUD::Logger.debug("Hero #{hero.inspect}")
        MUD::Logger.debug("Enemy #{enemy.inspect}")
      end

      def damage
        damage_dealt
        enemy_hp_after_attacking
      end

      # private

      def damage_dealt
        @dmg_dealt ||= begin
          dmg = attack_value - defence_value

          if dmg.negative?
            0
          else
            dmg
          end
        end
      end

      def attack_value
        rand((weapon.min_power)..(weapon.max_power))
      end

      def weapon
        MUD::Weapon.new(hero.weapon)
      end

      def defence_value
        enemy.defence
      end

      def enemy_hp_after_attacking
        if missed? || @dmg_dealt.zero?
          return MUD::Screen.output("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.")
        end

        MUD::Screen.output("You hit the #{enemy_name} with your #{weapon_name} for #{@dmg_dealt} damage.")
        update_enemy_hp

        if enemy_killed?
          MUD::Screen.output('Enemy killed')
          @enemy = nil
        else
          MUD::Logger.debug("DEBUG --> ENEMY HP:#{enemy_hp}hp.")
        end
      end

      def missed?
        rand > hero.accuracy
      end

      def enemy_name
        enemy.name
      end

      def weapon_name
        weapon.name
      end

      def update_enemy_hp
        enemy.hp -= @dmg_dealt
        enemy.prevent_negative_hp
      end

      def enemy_killed?
        enemy.dead?
      end

      def enemy_hp
        enemy.hp
      end
    end
  end
end
