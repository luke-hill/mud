puts 'Beginning autoloading'
require_relative 'autoloader'
puts 'Autoloading complete'

module MUD
  class Game
    include Singleton

    attr_reader :player
    attr_accessor :rooms_visited

    def initialize
      set_player_attributes
      create_player_object
      set_rooms_visited_to_blank
    end

    def connected_rooms
      player.current_room.connected_rooms
    end

    def move(direction)
      MUD::Movement::Move.send(direction)
    end

    private

    def set_player_attributes
      puts 'For now you must be a Fighter, with 25HP.'
    end

    def create_player_object
      @player ||= Fighter::Player.new
    end

    def set_rooms_visited_to_blank
      @rooms_visited ||= {}
    end
  end
end
