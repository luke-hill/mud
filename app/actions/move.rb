# frozen_string_literal: true

module MUD
  module Actions
    # This provides a single public method +#move+
    # This will make a series of checks which will determine if you are allowed to move
    # in the direction you requested. If all checks pass, you will then move in the desired
    # direction. Then the relevant room variables will be updated.
    class Move
      include Helpers::Data
      include Helpers::Methods

      attr_reader :direction

      def initialize(direction)
        @direction = direction
      end

      # @return [String]
      # This method will move in the relevant direction (If they pass the checks). Once you have
      # moved, a string representation of the movement is sent to the playing console.
      def move
        Logger.debug("Attempting to move #{direction}")
        return Screen.output(ktp_warning_message) unless player.current_room.exitable?
        return send(direction) unless key_required?

        move_through_locked_door
      end

      private

      def move_through_locked_door
        return Screen.output(Key.of_type(required_key).missing_message.red) unless required_key?

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
        @required_key ||= direction_yml.dig(player.current_room.room_id, "#{direction}_key_id")
      end

      def required_key?
        key_required? && required_key_in_inventory?
      end

      def required_key_in_inventory?
        player.inventory.include?(required_key)
      end

      def north
        return Screen.output('You cannot go north'.red) unless connected_rooms['north']

        travel('north')
      end

      def south
        return Screen.output('You cannot go south'.red) unless connected_rooms['south']

        travel('south')
      end

      def east
        return Screen.output('You cannot go east'.red) unless connected_rooms['east']

        travel('east')
      end

      def west
        return Screen.output('You cannot go west'.red) unless connected_rooms['west']

        travel('west')
      end

      def up
        return Screen.output('You cannot go up'.red) unless connected_rooms['up']

        travel('up')
      end

      def down
        return Screen.output('You cannot go down'.red) unless connected_rooms['down']

        travel('down')
      end

      def connected_rooms
        @connected_rooms ||= player.current_room.connected_rooms
      end

      def travel(direction)
        connected_rooms[direction].tap do |room_id|
          Logger.info("Moving to Room-ID: #{room_id}")
          Screen.output("You went #{direction}")
          player.current_room.leave
          player.current_room = fetch_or_create_room(room_id)
        end
        player.current_room.enter
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
        Room.new(room_id).tap do |room|
          break Shop.new(room_id) if room.shop?
        end
      end
    end
  end
end
