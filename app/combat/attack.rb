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

      # TODO: The values in this method  and the one below won't work
      def attack_value
        rand((weapon.atk_min)..(weapon.atk_max))
      end

      def defend_value
        rand(0..(armor.def))
      end
    end
  end
end
