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

        move_through_locked_door
      end

      private

      def move_through_locked_door
        return MUD::Screen.output(MUD::Key.new(required_key).missing_message.red) unless required_key?

        player.use(required_key)
        send(direction)
      end

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
        return MUD::Screen.output('You cannot go north'.red) unless connected_rooms['north']

        move_to('north', connected_rooms['north'])
      end
      alias n north

      def south
        return MUD::Screen.output('You cannot go south'.red) unless connected_rooms['south']

        move_to('south', connected_rooms['south'])
      end
      alias s south

      def east
        return MUD::Screen.output('You cannot go east'.red) unless connected_rooms['east']

        move_to('east', connected_rooms['east'])
      end
      alias e east

      def west
        return MUD::Screen.output('You cannot go west'.red) unless connected_rooms['west']

        move_to('west', connected_rooms['west'])
      end
      alias w west

      def up
        return MUD::Screen.output('You cannot go up'.red) unless connected_rooms['up']

        move_to('up', connected_rooms['up'])
      end

      def down
        return MUD::Screen.output('You cannot go down'.red) unless connected_rooms['down']

        move_to('down', connected_rooms['down'])
      end

      def connected_rooms
        @connected_rooms ||= player.current_room.connected_rooms
      end

      def move_to(direction, room_id)
        MUD::Logger.info("Moving to Room-ID: #{room_id}")
        MUD::Screen.output("You went #{direction}")
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
        MUD::Room.new(room_id).tap do |room|
          break MUD::Shop.new(room_id) if room.shop?
        end
      end
    end
  end
end
