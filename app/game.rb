# frozen_string_literal: true

# First calls must be +puts+ as the +MUD::Screen.output+ class method doesn't exist yet!
puts 'Beginning autoloading'
require_relative 'autoloader'
puts 'Autoloading complete'

module MUD
  class Game
    class << self
      attr_accessor :rooms_visited

      # @return Classes::Fighter
      # The game will be initiated displaying the introduction message/s, then providing the class to be used ingame
      def setup
        display_welcome_message
        player
      end

      # @return Classes::Fighter
      # The game will be completely reset, with all progress deleted.
      # The game will then be re-setup to provide the class to be used ingame
      def reset
        instance_variables.each { |var| remove_instance_variable(var) }
        setup
      end

      # @return Classes::Fighter
      # The player class being used ingame
      def player
        @player ||= Classes::Fighter.new
      end

      private

      def display_welcome_message
        output_diagnostic_info
        output_intro_to_game_info
      end

      def output_diagnostic_info
        sleep 0.25
        MUD::Screen.output('............................................')
        sleep 0.25
        MUD::Screen.output('Hello and Welcome to Adventures of avaLancHe - Working title I know!!')
        sleep 0.5
        MUD::Screen.output("Current Version #{VERSION}")
        sleep 0.5
        MUD::Screen.output('For now you are a Fighter, with 25HP.').blink
      end

      def output_intro_to_game_info
        sleep 0.5
        MUD::Screen.output(
          "Whilst you're here, let me give you the down-low. You're about to begin your quest"
        )
        sleep 0.5
        MUD::Screen.output(
          'You are in Newtown, and as avaLancHe ... our intrepid explorer, you have spawned '\
          'in our village to kill Several Monsters and then the boss - The Orc!'
        )
      end
    end
  end
end
