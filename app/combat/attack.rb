module MUD
  module Combat
    class Attack
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      def debug
        puts "Hero #{hero.inspect}"
        puts "Enemy #{enemy.inspect}"
      end
    end
  end
end
