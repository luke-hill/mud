# frozen_string_literal: true

require_relative 'game'

module MUD
  # This class takes the user input whilst playing the game. And then hands it off to
  # a middleware which processes it and then that in turn hands it off to the models / actions
  # which then do the "gameplay"
  #
  # Once the action/s have completed, we check to see if we're +alive?+ and then we repeat the
  # logic again
  class Play
    class << self
      # This is the method that will continually scan for whether the user is alive
      # If the user is still alive, the game continues
      def play
        setup
        Actions::Command.new(user_input).process

        continue_or_die
      end

      private

      def continue_or_die
        if player.alive?
          play
        else
          die
        end
      end

      def user_input
        $stdin.gets.chomp.split.first.to_s.downcase
      end

      def setup
        ENV['DATA_SOURCE'] = 'data'
        Game.setup
      end

      def player
        @player ||= Game.player
      end

      def die
        Screen.output('You died'.red)
        Kernel.exit
      end
    end
  end
end
