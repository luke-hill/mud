module MUD
  module Rooms
    class Room
      include MUD::Helpers::Data

      attr_reader :room_id
      attr_accessor :times_visited

      def initialize(room_id)
        @room_id = room_id
        @times_visited = 1
      end

      def directions
        @directions ||= directions_yml[room_id]
      end

      def description
        @description ||= descriptions_yml.dig(room_id, 'description')
      end

      def advanced_description
        @advanced_description ||= descriptions_yml.dig(room_id, 'advanced_description')
      end

      def visit
        self.times_visited += 1
      end

      def leave
        game.rooms_visited[room_id] = self
      end

      def game
        MUD::Game.instance
      end
    end
  end
end
