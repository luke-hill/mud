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
    def play
      MUD::Actions::Command.new(user_input).process while player.alive?
      die
    end

    private

    def user_input
      gets.chomp.split.first.to_s.downcase
    end

    def player
      @player ||= MUD::Game.setup
    end

    def die
      MUD::Screen.output('You died'.red)
      sleep 2
      exit
    end
  end
end

Play.new.play
