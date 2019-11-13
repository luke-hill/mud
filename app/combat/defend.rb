# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#defend+
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will perform the act of the enemy attacking the hero
    # (With the Attack class doing the opposite)
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

      # @return [String, StandardError]
      # This will make a single enemy on hero attack using the enemies weapon
      # if the attack misses or deals 0 damage, then a missed message is output.
      # Otherwise the attack succeeds and outputs a message indicating the damage and then
      # deducts that amount from the heroes hp.
      #
      # If the attack kills the hero. The game crashes.
      def defend
        return missed_message if no_damage?

        attack_message
        reduce_hp

        return MUD::Screen.output("DEBUG --> YOUR HP:#{hero.hp}hp.") unless hero_killed?

        raise StandardError, 'You died!'
      end

      private

      def missed_message
        MUD::Screen.output(
          "The #{enemy_name} swung at you with its #{weapon_name}, but missed.".yellow
        )
      end

      def enemy_name
        enemy.name
      end

      def weapon_name
        weapon.name
      end

      def no_damage?
        missed? || damage_taken.zero?
      end

      def missed?
        rand > enemy.accuracy
      end

      def damage_taken
        @damage_taken ||= begin
          dmg = attack_value - defense_value

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
        MUD::Weapon.new(enemy.weapon_id)
      end

      def defense_value
        rand(0..(armor.defense))
      end

      def armor
        MUD::Armor.new(hero.armor)
      end

      def attack_message
        MUD::Screen.output(
          "The #{enemy_name} hit you with its #{weapon_name} for #{damage_taken} damage."
        )
      end

      def reduce_hp
        hero.hp -= damage_taken
        hero.prevent_negative_hp
      end

      def hero_killed?
        hero.dead?
      end
    end
  end
end
