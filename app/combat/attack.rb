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

      def attack
        return missed_message if no_damage?

        attack_message
        reduce_enemy_hp

        return MUD::Logger.debug("DEBUG --> ENEMY HP:#{enemy.hp}hp.") unless enemy_killed?

        kill_message
        @enemy = nil
      end

      private

      def missed_message
        MUD::Screen.output("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.")
      end

      def no_damage?
        missed? || damage_dealt.zero?
      end

      def missed?
        rand > hero.accuracy
      end

      def damage_dealt
        @damage_dealt ||= begin
          dmg = attack_value - defense_value

          if dmg.negative?
            0
          else
            dmg
          end
        end
      end

      def attack_message
        MUD::Screen.output("You hit the #{enemy_name} with your #{weapon_name} for #{damage_dealt} damage.")
      end

      def enemy_name
        enemy.name
      end

      def weapon_name
        weapon.name
      end

      def attack_value
        rand((weapon.min_power)..(weapon.max_power))
      end

      def weapon
        MUD::Weapon.new(hero.weapon)
      end

      def defense_value
        rand(0..(enemy.defense))
      end

      def reduce_enemy_hp
        enemy.hp -= damage_dealt
        enemy.prevent_negative_hp
      end

      def enemy_killed?
        enemy.dead?
      end

      def kill_message
        MUD::Screen.output("You killed the #{enemy_name}.".blink)
      end
    end
  end
end
