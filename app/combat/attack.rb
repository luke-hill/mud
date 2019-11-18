# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#attack+
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will perform the act of the hero attacking the enemy
    # (With the Defend class doing the opposite)
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

      # @return [String, NilClass]
      # This will make a single hero on enemy attack using the heroes weapon
      # if the attack misses or deals 0 damage, then a missed message is output.
      # Otherwise the attack succeeds and outputs a message indicating the damage and then
      # deducts that amount from the enemies hp.
      #
      # If the attack kills the enemy. The enemy is deleted from the room.
      def attack
        return missed_message if no_damage?

        attack_message
        reduce_hp
        return MUD::Screen.output("DEBUG --> ENEMY HP:#{enemy.hp}hp.") unless enemy_killed?

        @enemy = nil
      end

      private

      def missed_message
        MUD::Screen.output(
          "You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow
        )
      end

      def enemy_name
        enemy.name
      end

      def weapon_name
        weapon.name
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

      def attack_value
        rand((weapon.min_power)..(weapon.max_power))
      end

      def weapon
        MUD::Weapon.new(hero.weapon)
      end

      def defense_value
        rand(0..(enemy.defense))
      end

      def attack_message
        MUD::Screen.output(
          "You hit the #{enemy_name} with your #{weapon_name} for #{damage_dealt} damage."
        )
      end

      def reduce_hp
        enemy.hp -= damage_dealt
        enemy.prevent_negative_hp
      end

      def enemy_killed?
        enemy.dead?
      end
    end
  end
end
