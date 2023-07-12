# frozen_string_literal: true

module MUD
  module Combat
    # This provides methods which determine how much experience the hero should gain in a
    # single +#MUD::Combat::Attack.attack+ call
    # This is entirely api private but it will be called by using +MUD::Combat::Fight.fight+
    # This will perform the act of the hero earning experience, and dependent on current xp
    # or amount earned, possibly capping their experience and preventing more being accumulated.
    class XP
      attr_reader :hero, :enemy, :damage_dealt

      def initialize(hero, enemy, damage_dealt)
        @hero = hero
        @enemy = enemy
        @damage_dealt = damage_dealt
      end

      # @return [Nil]
      # This will increase the heroes experience and Log it accordingly.
      # Nothing is returned to the playing console as this is all hidden.
      #
      # If the user is originally capped then the entire method is skipped and a
      # message is sent to notify the hero that they should level up.
      def increase
        return xp_capped_message if hero.capped?

        increase_hero_xp
        Screen.debug("Hero xp increased by #{total_xp_gain}")
        nil
      end

      private

      def xp_capped_message
        Screen.output('You feel strong enough to reach the next level. Seek out a Guild.'.yellow.blink)
      end

      def increase_hero_xp
        hero.experience += total_xp_gain
      end

      def total_xp_gain
        regular_xp_gain + xp_killshot_bonus
      end

      def regular_xp_gain
        if killshot?
          enemy.hp * enemy.xp
        else
          damage_dealt * enemy.xp
        end
      end

      def killshot?
        damage_dealt >= enemy.hp
      end

      def xp_killshot_bonus
        if killshot?
          enemy.xp_killshot
        else
          0
        end
      end
    end
  end
end
