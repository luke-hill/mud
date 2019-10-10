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

      # TODO: The values in this method won't work They also need modifying after v2 to factor in strength!
      def attack_value
        rand((weapon.atk_min)..(weapon.atk_max))
      end
    end
  end
end
