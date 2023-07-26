# frozen_string_literal: true

module MUD
  module Presenters
    # The Presentational Layer for showing Enemies to the User
    #
    # This essentially will make a couple of checks on the enemy.
    # Based on the results of this, it will return a formatted style for the enemy name
    # to the user to be used after the initial `description` or `advanced_description` string (with directions)
    # has been outputted.
    class Enemy
      include Helpers::Data

      attr_reader :enemy

      def initialize(enemy)
        @enemy = enemy
      end

      # @return [String]
      # The enemy name formatted appropriately
      def string
        return 'No enemies are in the room.' if enemy.id == 'no_enemy' || enemy.dead?
        return "The #{enemy.name} is here with you.".bold if boss?

        "A #{enemy.name} is here with you."
      end

      private

      def boss?
        enemy.type == :boss
      end
    end
  end
end
