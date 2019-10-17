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

      def fight
        return MUD::Screen.output('There is no enemy present'.red) if enemy.nil?

        @dmg_dealt = damage_dealt
        @dmg_taken = damage_taken
        enemy_hp_after_attacking
        if enemy_killed?
          room.enemy_death_message
        else
          new_hp_after_taking_hit
        end
      end

      private

      def damage_dealt
        dmg = hero_attack_value - enemy_defence_value

        if dmg.negative?
          0
        else
          dmg
        end
      end

      def damage_taken
        dmg = enemy_attack_value - hero_defence_value

        if dmg.negative?
          0
        else
          dmg
        end
      end

      def hero_attack_value
        rand((hero.weapon.atk_min)..(hero.weapon.atk_max))
      end

      def enemy_defence_value
        enemy.defend_value
      end

      def enemy_attack_value
        enemy.attack_value
      end

      def hero_defence_value
        rand(0..(hero.armor.def))
      end

      def enemy_hp_after_attacking
        if hero_missed? || @dmg_dealt.zero?
          return MUD::Screen.output("You tried to attack the #{enemy_name} with your #{hero_weapon_name}... but missed.")
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

      def enemy_name
        enemy.name
      end

      def hero_weapon_name
        hero.weapon.name
      end

      def hero_missed?
        rand > hero.accuracy
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

      def enemy_weapon_name
        enemy.weapon.name
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
