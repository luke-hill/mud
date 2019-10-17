module MUD
  class Room
    include Helpers::Data

    attr_reader :room_id
    attr_accessor :times_visited

    def initialize(room_id)
      @room_id = room_id
      @times_visited = 0
    end

    def connected_rooms
      @connected_rooms ||= directions_yml[room_id]
    end

    def description
      @description ||= descriptions_yml.dig(room_id, 'description')
    end

    def advanced_description
      @advanced_description ||= descriptions_yml.dig(room_id, 'advanced_description')
    end

    def visit
      MUD::Logger.debug("Visiting Room-ID: #{room_id}")
      MUD::Screen.output(room.description.yellow)
      self.times_visited += 1
    end

    def leave
      player.rooms_visited[room_id] = self
    end
  end
end
