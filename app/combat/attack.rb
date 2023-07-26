# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#attack+
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will perform the act of the player attacking the enemy
    # (With the Defend class doing the opposite)
    class Attack
      attr_reader :enemy

      include Helpers::Methods

      def initialize(enemy)
        @enemy = enemy
      end

      # @return [String, NilClass]
      # This will make a single player on enemy attack using the players weapon
      # if the attack misses or deals 0 damage, then a missed message is output.
      # Otherwise the attack succeeds and outputs a message indicating the damage and then
      # deducts that amount from the enemies hp.
      #
      # If the attack kills the enemy. The enemy is deleted from the room.
      def attack
        return missed_message if no_damage?

        attack_message
        XP.new(enemy, damage_dealt).increase
        reduce_enemy_hp
        Logger.debug("Enemy hp:#{enemy.hp}hp.")
      end

      private

      def missed_message
        Screen.output("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow)
      end

      def enemy_name
        enemy.name
      end

      def weapon_name
        player.weapon.name
      end

      def no_damage?
        missed? || damage_dealt.zero?
      end

      def missed?
        (rand > player.accuracy).tap do |result|
          Logger.debug("Missed check - #{result}")
        end
      end

      def damage_dealt
        @damage_dealt ||= begin
          dmg = (attack_value - defense_value).tap do |result|
            Logger.debug("Initial damage check - #{result}")
          end

          if dmg.negative?
            0
          else
            dmg
          end
        end
      end

      def attack_value
        initial_attack_value + attack_modifiers
      end

      def initial_attack_value
        rand((player.weapon.min_power)..(player.weapon.max_power))
      end

      def attack_modifiers
        (player.strength / 2).floor + player.level
      end

      def defense_value
        rand(0..(enemy.defense))
      end

      def attack_message
        Screen.output("You hit the #{enemy_name} with your #{weapon_name} for #{damage_dealt} damage.")
      end

      def reduce_enemy_hp
        enemy.hp -= damage_dealt
        enemy.prevent_negative_hp
      end
    end
  end
end
