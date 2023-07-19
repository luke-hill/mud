# frozen_string_literal: true

module MUD
  module Combat
    # This provides a single public method +#fight+
    # This is the public interface to killing enemies. And is the only method which is public.
    class Fight
      attr_reader :enemy

      include Helpers::Methods

      def initialize(enemy)
        @enemy = enemy
      end

      # @return [String]
      # Attempt to fight an enemy. A series of checks are made and then attacks are made
      # in a sequential order (Hero always first).
      #
      # Once these checks pass / attacks are made. The +Screen.output+ method is called on
      # each invocation and result/s are outputted to the screen about what happened during the
      # iteration of +fight+
      def fight(times)
        if times == 1
          fight_once
        else
          fight_until_death
        end
      end

      private

      def fight_once
        return Screen.output('There is no enemy present'.red) if enemy.nil? || enemy_dead?

        attack

        if enemy_dead?
          notify_enemy_killed
          process_item_drops
        else
          enemy.speak
          defend
        end
      end

      def attack
        Attack.new(enemy).attack
      end

      def defend
        Defend.new(enemy).defend
      end

      def enemy_dead?
        enemy.dead?
      end

      def notify_enemy_killed
        Screen.output("You killed the #{enemy.name}.".blue.blink)
      end

      def process_item_drops
        ItemDrops.new(enemy).process
      end

      def fight_until_death
        fight_once until player.dead? || enemy_dead?
      end
    end
  end
end
