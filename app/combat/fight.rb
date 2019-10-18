module MUD
  module Combat
    class Fight
      attr_reader :hero, :enemy

      def initialize(hero, enemy)
        @hero = hero
        @enemy = enemy
      end

      def fight(times)
        if times == 1
          fight_once
        else
          fight_until_death
        end
      end

      def fight_once
        return MUD::Screen.output('There is no enemy present'.red) if enemy.nil?

        Attack.new(hero, enemy).attack

        if enemy_killed?
          MUD::Screen.output("You killed the #{enemy.name}".blue.blink)
        else
          Defend.new(hero, enemy).defend
        end
      end

      def fight_until_death
        fight_once until hero.dead? || enemy.dead?
      end
    end
  end
end
