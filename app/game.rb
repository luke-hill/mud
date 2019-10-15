# First calls must be puts as the +MUD::Screen.output+ class method doesn't exist yet!

puts 'Beginning autoloading'
require_relative 'autoloader'
puts 'Autoloading complete'

module MUD
  class Game
    class << self
      attr_reader :player
      attr_accessor :rooms_visited

      def setup
        Logger.info('Game started'.red)
        display_welcome_message
        set_rooms_visited_to_blank
        create_player_object
      end

      # TODO: This should be a player method
      def connected_rooms
        player.connected_rooms
      end

      # TODO: This should be a player method
      def move(direction)
        player.move(direction)
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
        MUD::Screen.output 'For now you are a Fighter, with 25HP.'.blink
        sleep 0.75
        MUD::Screen.output "Whilst you're here, let me give you the down-low. You're about to begin your quest"
        sleep 0.75
        MUD::Screen.output 'You are in Newtown, and as avaLancHe ... our intrepid explorer, you have spawned in our village to kill Several Monsters and then the boss - The Orc!'
        sleep 0.5
        MUD::Screen.output '............................................'
      end

      def development?
        true
      end

      def create_player_object
        @player ||= Classes::Fighter.new
      end

      # TODO: Move this to player object also
      def set_rooms_visited_to_blank
        @rooms_visited ||= {}
      end
    end
  end
end
