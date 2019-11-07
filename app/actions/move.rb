# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#move+
    # This will make a series of checks which will determine if you are allowed to move
    # in the direction you requested. If all checks pass, you will then move in the desired
    # direction. Then the relevant room variables will be updated.
    class Move
      include MUD::Helpers::Data

      attr_reader :player

      def initialize(player)
        @player = player
      end

      # @return [String]
      # This method will move in the relevant direction (If they pass the checks). Once you have
      # moved, a string representation of the movement is sent to the playing console.
      def move(direction)
        if player.current_room.exitable?
          if required_key(direction)
            if player.barracks_key?
              player.use('barracks_key')
              send(direction)
            else
              MUD::Screen.output(MUD::Key.new('barracks_key').missing_message.red)
            end
          else
            send(direction)
          end
        else
          MUD::Screen.output(
            "You must kill the #{player.current_room.enemy.name} before leaving the room!".red
          )
        end
      end

      # @return [String]
      # This is an unused API method currently and will be removed
      def pickup_item
        MUD::Screen.output('Not in active use'.red)
      end

      # @return [String]
      # This is an unused API method currently and will be removed
      def drop_item
        MUD::Screen.output('Not in active use'.red)
      end

      # @return [String]
      # This is an unused API method currently and will be removed
      def pickup_gold
        MUD::Screen.output('Not in active use'.red)
      end

      # @return [String]
      # This is an unused API method currently and will be removed
      def drop_gold
        MUD::Screen.output('Not in active use'.red)
      end

      private

      def required_key(direction)
        direction_yml.dig(player.current_room.room_id, "#{direction}_key_id")
      end

      def north
        if north_room_id
          MUD::Screen.output('You went north')
          move_to(north_room_id)
        else
          MUD::Screen.output('You cannot go north'.red)
        end
      end

      def south
        if south_room_id
          MUD::Screen.output('You went south')
          move_to(south_room_id)
        else
          MUD::Screen.output('You cannot go south'.red)
        end
      end

      def east
        if east_room_id
          MUD::Screen.output('You went east')
          move_to(east_room_id)
        else
          MUD::Screen.output('You cannot go east'.red)
        end
      end

      def west
        if west_room_id
          MUD::Screen.output('You went west')
          move_to(west_room_id)
        else
          MUD::Screen.output('You cannot go west'.red)
        end
      end

      def up
        if up_room_id
          MUD::Screen.output('You went up')
          move_to(up_room_id)
        else
          MUD::Screen.output('You cannot go up'.red)
        end
      end

      def down
        if down_room_id
          MUD::Screen.output('You went down')
          move_to(down_room_id)
        else
          MUD::Screen.output('You cannot go down'.red)
        end
      end

      def north_room_id
        connected_rooms['north']
      end

      def south_room_id
        connected_rooms['south']
      end

      def east_room_id
        connected_rooms['east']
      end

      def west_room_id
        connected_rooms['west']
      end

      def up_room_id
        connected_rooms['up']
      end

      def down_room_id
        connected_rooms['down']
      end

      def connected_rooms
        player.current_room.connected_rooms
      end

      def move_to(room_id)
        MUD::Logger.info("Moving to Room-ID: #{room_id}")
        player.current_room.leave
        player.current_room = fetch_or_create_room(room_id)
        player.current_room.visit
      end

      def fetch_or_create_room(room_id)
        if room_already_visited?(room_id)
          fetch_room_from_cache(room_id)
        else
          create_room(room_id)
        end
      end

      def room_already_visited?(room_id)
        player.rooms_visited.include?(room_id)
      end

      def fetch_room_from_cache(room_id)
        player.rooms_visited[room_id]
      end

      def create_room(room_id)
        if shop?(room_id)
          MUD::Shop.new(room_id)
        else
          MUD::Room.new(room_id)
        end
      end

      def shop?(room_id)
        type(room_id).end_with?('Shop')
      end

      def type(room_id)
        description_yml.dig(room_id, 'type')
      end
    end
  end
end
