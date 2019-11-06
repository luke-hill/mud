# frozen_string_literal: true

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

      private

      def fight_once
        return MUD::Screen.output('There is no enemy present'.red) if enemy.nil?

        attack

        if enemy_killed?
          MUD::Screen.output("You killed the #{enemy.name}.".blue.blink)
          ItemDrops.new(hero, enemy).process
        else
          Defend.new(hero, enemy).defend
        end
      end

      def fight_until_death
        fight_once until hero.dead? || enemy.dead?
      end

      def attack
        attack_class.attack
      end

      def enemy_killed?
        enemy.dead?
      end

      def attack_class
        @attack_class ||= Attack.new(hero, enemy)
      end
    end
  end
end
