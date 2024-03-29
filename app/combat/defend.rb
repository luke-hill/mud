# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#defend+
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will perform the act of the enemy attacking the player
    # (With the Attack class doing the opposite)
    class Defend
      attr_reader :enemy

      include Helpers::Methods

      def initialize(enemy)
        @enemy = enemy
      end

      # @return [String, StandardError]
      # This will make a single enemy on player attack using the enemies weapon
      # if the attack misses or deals 0 damage, then a missed message is output.
      # Otherwise the attack succeeds and outputs a message indicating the damage and then
      # deducts that amount from the players hp.
      #
      # If the attack kills the player. The game crashes.
      def defend
        return missed_message if no_damage?

        attack_message
        reduce_player_hp

        return Screen.output("DEBUG --> YOUR HP:#{player.hp}hp.") unless player_killed?

        raise StandardError, 'You died!'
      end

      private

      def missed_message
        Screen.output("The #{enemy_name} swung at you with its #{weapon_name}, but missed.".yellow)
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
        Weapon.of_type(enemy.weapon_id)
      end

      def defense_value
        initial_defense_value + defense_modifiers
      end

      def initial_defense_value
        rand(0..(player.armor.defense))
      end

      def defense_modifiers
        (player.strength / 3).floor + (player.level / 2).floor
      end

      def attack_message
        Screen.output("The #{enemy_name} hit you with its #{weapon_name} for #{damage_taken} damage.")
      end

      def reduce_player_hp
        player.hp -= damage_taken
        player.prevent_negative_hp
      end

      def player_killed?
        player.dead?
      end
    end
  end
end
