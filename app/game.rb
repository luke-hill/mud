# frozen_string_literal: true

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
        Screen.output('Game started'.red)
        display_welcome_message
        create_player_object
      end

      def reset!
        self.instance_variables.each { |var| remove_instance_variable(var) }
        setup
      end

      private

      def display_welcome_message
        return if development?

        sleep 0.5
        MUD::Screen.output '............................................'
        sleep 0.5
        MUD::Screen.output "Hello and Welcome to MUD - Working title I know!!"
        sleep 0.75
        MUD::Screen.output "Current Version #{VERSION}"
        sleep 0.75
        MUD::Screen.output 'For now you are a Fighter, with 25HP.'.blink
        sleep 0.75
        MUD::Screen.output "Whilst you're here, let me give you the down-low. You're about to begin your quest"
        sleep 0.75
        MUD::Screen.output 'You are in Newtown, and as avaLancHe ... our intrepid explorer, you have spawned in our '\
'village to kill Several Monsters and then the boss - The Orc!'
        sleep 0.5
        MUD::Screen.output '............................................'
      end

      def development?
        true
      end

      def create_player_object
        @player ||= Classes::Fighter.new
      end
    end
  end
end
