module MUD
  module Combat
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

      # TODO: The values in this method won't work They also need modifying after v2 to factor in strength!
      def defend_value
        rand(0..(armor.def))
      end
    end
  end
end
