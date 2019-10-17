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

        @dmg_dealt = Attack.new(hero, enemy).damage

        if enemy_killed?
          room.enemy_death_message
        else
          @dmg_taken = Defend.new(hero, enemy).defend
        end
      end

      def fight_until_death
        fight_once until hero.dead? || enemy.dead?
      end
    end
  end
end
