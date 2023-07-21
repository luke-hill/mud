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
    include Helpers::Methods

    attr_reader :room_id
    attr_accessor :times_visited, :floor

    def initialize(room_id)
      @room_id = room_id
      @times_visited = 0
      @floor = []
    end

    # @return [String]
    # The standard description of the room
    # This description will be comprised of a message, followed by an indication of all visible directions in yellow
    def description
      "#{description_yml.dig(room_id, 'description')}\n#{enemy_string.blue}\n#{directions_string.yellow}"
    end

    # @return [String]
    # The advanced description of the room
    # This description will be comprised of a message, followed by an indication of all visible directions in yellow
    def advanced_description
      "#{description_yml.dig(room_id, 'advanced_description')}\n#{enemy_string.blue}\n#{directions_string.yellow}"
    end

    # @return [Integer]
    # The method that is called when you first enter a room. It will increase the times_visited count by 1
    def enter
      Logger.debug("Entering Room-ID: #{room_id} Description: #{description}")
      Screen.output(description)
      self.times_visited += 1
    end

    # @return [Integer]
    # The method that is called when you leave a room
    #
    # It will overwrite the rooms_visited cache to represent the state the room was in just as you left it - so things
    # like the floor will remain constant and enemies will remain as they were
    def leave
      player.rooms_visited[room_id] = self
    end

    # @return [Hash]
    # A list of the connected room ids relevant to the current room
    def connected_rooms
      direction_yml[room_id]
    end

    # @return [Boolean]
    # Whether there is an alive enemy? (See MUD::Enemy for implementation details)
    def enemy?
      enemy&.alive?
    end

    # @return [MUD::Enemy]
    # The enemy that is defined to be in the room
    def enemy
      @enemy ||= Enemy.of_type(description_yml.dig(room_id, 'enemy_id'))
    end

    # @return [Boolean]
    # Whether the player can exit the room by moving (Requires there not to be a ktp enemy)
    def exitable?
      !(ktp? && enemy?)
    end

    # @return [Boolean]
    # Whether the room we are in is classed as a shop (NB: This should create a MUD::Shop instance when this is the case)
    def shop?
      type.end_with?('Shop')
    end

    # @return [String]
    # The type of room you are in
    def type
      description_yml.dig(room_id, 'type')
    end

    private

    def directions_string
      @directions_string ||= Presenters::Directions.new(room_id).string
    end

    def enemy_string
      Presenters::Enemy.new(enemy).string
    end

    def ktp?
      description_yml.dig(room_id, 'ktp')
    end
  end
end
