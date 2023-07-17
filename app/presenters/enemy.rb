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
        return 'No enemies are in the room.' if enemy.id == 'no_enemy'

        case enemy.type
        when :enemy; then "A #{enemy.name} is here with you."
        when :boss;  then "The #{enemy.name} is here with you.".bold
        else raise "This room (Room-ID: #{room_id}), is incorrectly configured"
        end
      end
    end
  end
end