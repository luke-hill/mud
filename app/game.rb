# First calls must be puts as the +MUD::Screen.output+ class method doesn't exist yet!

puts 'Beginning autoloading'
require_relative 'autoloader'
puts 'Autoloading complete'

module MUD
  class Game
    include Singleton

    attr_reader :player
    attr_accessor :rooms_visited

    def initialize
      Logger.info('Game started'.red)
      set_player_attributes
      create_player_object
      set_rooms_visited_to_blank
    end

    def connected_rooms
      player.current_room.connected_rooms
    end

    def move(direction)
      Logger.debug("Attempting to move #{direction}")
      MUD::Movement::Move.send(direction)
    end

    def reset!
      self.instance_variables.each { |var| remove_instance_variable(var) }
      initialize
    end

    private

    def display_welcome_message
      return if development?

      sleep 0.5
      MUD::Screen.output '............................................'
      sleep 0.5
      MUD::Screen.output "Hello and Welcome to MUD - Working title I know!!"
      sleep 0.75
      MUD::Screen.output "Current Version #{game_version}"
      sleep 0.75
      MUD::Screen.output "Whilst you're here, let me give you the down-low. You're about to begin LevelOne"
      sleep 0.75
      MUD::Screen.output 'LevelOne, sees you spawn in our village against Several Monsters and then the boss - The Orc!'
      sleep 0.5
      MUD::Screen.output '............................................'
    end

    def development?
      true
    end

    def set_player_attributes
      MUD::Screen.output 'For now you are a Fighter, with 25HP.'.blink
    end

    def create_player_object
      @player ||= Classes::Fighter.new
    end

    def set_rooms_visited_to_blank
      @rooms_visited ||= {}
    end
  end
end
