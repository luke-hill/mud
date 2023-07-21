# frozen_string_literal: true

module MUD
  module Helpers
    # Helpers to give you simple methods used in lots of places
    module Methods
      # @return [MUD::Classes::Fighter]
      # The active player inside the game
      def player
        MUD::Game.player
      end
    end
  end
end
