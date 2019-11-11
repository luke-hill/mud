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
          notify_enemy_killed
          process_item_drops
        else
          Defend.new(hero, enemy).defend
        end
      end

      def attack
        Attack.new(hero, enemy).attack
      end

      def enemy_killed?
        enemy.dead?
      end

      def notify_enemy_killed
        MUD::Screen.output("You killed the #{enemy.name}.".blue.blink)
      end

      def process_item_drops
        ItemDrops.new(hero, enemy).process
      end

      def fight_until_death
        fight_once until hero.dead? || enemy_killed?
      end
    end
  end
end
