# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#move+
    # This will make a series of checks which will determine if you are allowed to move
    # in the direction you requested. If all checks pass, you will then move in the desired
    # direction. Then the relevant room variables will be updated.
    class Move
      include MUD::Helpers::Data
      include MUD::Helpers::Unnabbreviater

      attr_reader :player, :direction

      def initialize(player, direction)
        @player = player
        @direction = direction
      end

      # @return [String]
      # This method will move in the relevant direction (If they pass the checks). Once you have
      # moved, a string representation of the movement is sent to the playing console.
      def move
        return MUD::Screen.output(ktp_warning_message) unless player.current_room.exitable?
        return send(direction) unless key_required?

        if required_key?
          player.use(required_key)
          send(direction)
        else
          MUD::Screen.output(MUD::Key.new(required_key).missing_message.red)
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

      private

      def ktp_warning_message
        "You must kill the #{player.current_room.enemy.name} before leaving the room!".red
      end

      def key_required?
        !required_key.nil?
      end

      def required_key
        @required_key ||= direction_yml.dig(player.current_room.room_id, "#{unnabbreviate(direction, type: :movement)}_key_id")
      end

      def required_key?
        key_required? && required_key_in_inventory?
      end

      def required_key_in_inventory?
        player.inventory.include?(required_key)
      end

      def north
        return MUD::Screen.output('You cannot go north'.red) unless north_room_id

        MUD::Screen.output('You went north')
        move_to(north_room_id)
      end
      alias n north

      def south
        return MUD::Screen.output('You cannot go south'.red) unless south_room_id

        MUD::Screen.output('You went south')
        move_to(south_room_id)
      end
      alias s south

      def east
        return MUD::Screen.output('You cannot go east'.red) unless east_room_id

        MUD::Screen.output('You went east')
        move_to(east_room_id)
      end
      alias e east

      def west
        return MUD::Screen.output('You cannot go west'.red) unless west_room_id

        MUD::Screen.output('You went west')
        move_to(west_room_id)
      end
      alias w west

      def up
        return MUD::Screen.output('You cannot go up'.red) unless up_room_id

        MUD::Screen.output('You went up')
        move_to(up_room_id)
      end

      def down
        return MUD::Screen.output('You cannot go down'.red) unless down_room_id

        MUD::Screen.output('You went down')
        move_to(down_room_id)
      end

      def north_room_id
        @north_room_id ||= connected_rooms['north']
      end

      def south_room_id
        @south_room_id ||= connected_rooms['south']
      end

      def east_room_id
        @east_room_id ||= connected_rooms['east']
      end

      def west_room_id
        @west_room_id ||= connected_rooms['west']
      end

      def up_room_id
        @up_room_id ||= connected_rooms['up']
      end

      def down_room_id
        @down_room_id ||= connected_rooms['down']
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
        return fetch_room_from_cache(room_id) if room_already_visited?(room_id)

        create_room(room_id)
      end

      def room_already_visited?(room_id)
        player.rooms_visited.include?(room_id)
      end

      def fetch_room_from_cache(room_id)
        player.rooms_visited[room_id]
      end

      def create_room(room_id)
        return MUD::Shop.new(room_id) if shop?(room_id)

        MUD::Room.new(room_id)
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
