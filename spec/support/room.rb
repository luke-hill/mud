# frozen_string_literal: true

module SpecSupport
  class Room < MUD::Room
    def current_room_id
      MUD::Game.player.current_room.room_id
    end

    def reset_room
      MUD::Game.player.current_room = MUD::Room.new(1)
    end
  end
end
