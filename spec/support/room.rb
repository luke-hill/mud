# frozen_string_literal: true

module SpecSupport
  module Room
    def current_room_id
      MUD::Game.player.current_room.room_id
    end
  end
end
