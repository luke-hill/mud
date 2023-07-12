# frozen_string_literal: true

module MUD
  # The top level Room Class
  # This acts a bit like ActiveRecord, and will load the room into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  #
  # Methods which can access some of the properties of the room are also stored here as well
  # as helpful booleans and other ease of access methods
  class Room
    include Helpers::Data

    attr_reader :room_id
    attr_accessor :times_visited, :floor

    def initialize(room_id)
      @room_id = room_id
      @times_visited = 0
      @floor = []
    end

    def description
      @description ||= "#{description_yml.dig(room_id, 'description').blue}\n#{directions_string.yellow}"
    end

    def advanced_description
      @advanced_description ||=
        "#{description_yml.dig(room_id, 'advanced_description').blue}\n#{directions_string.yellow}"
    end

    def visit
      Logger.debug("Visiting Room-ID: #{room_id} Description: #{description}")
      Screen.output(description)
      self.times_visited += 1
    end

    def leave
      player.rooms_visited[room_id] = self
    end

    def connected_rooms
      direction_yml[room_id]
    end

    def enemy?
      enemy&.alive?
    end

    def enemy
      @enemy ||= Enemy.of_type(description_yml.dig(room_id, 'enemy_id'))
    end

    def exitable?
      !(ktp? && enemy?)
    end

    def shop?
      type.end_with?('Shop')
    end

    def type
      description_yml.dig(room_id, 'type')
    end

    private

    def directions_string
      @directions_string ||= Presenters::Directions.new(room_id).string
    end

    def visible_directions
      connected_rooms.keys
    end

    def visible_directions_as_string
      visible_directions.to_sentence(last_word_connector: ' and ')
    end

    def ktp?
      description_yml.dig(room_id, 'ktp')
    end
  end
end
