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
    def initialize
      setup
    end

    def play
      Actions::Command.new(user_input).process
      if player.alive?
        play
      else
        die
      end
    end

    private

    def user_input
      $stdin.gets.chomp.split.first.to_s.downcase
    end

    def setup
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
