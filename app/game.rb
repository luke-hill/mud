# frozen_string_literal: true

# First calls must be +puts+ as the +Screen.output+ class method doesn't exist yet!
puts 'Beginning autoloading'
require_relative 'autoloader'
puts 'Autoloading complete'

module MUD
  # MUD::Game
  #
  # The actual gameplay is setup here.
  # - Initially we make a call to MUD::Game.setup to generate a player instance
  # - Throughout the game, we can query publically both the player object as well as reset the entire game (If needed)
  class Game
    class << self
      attr_accessor :rooms_visited

      # @return Classes::Fighter
      # The game will be initiated displaying the introduction message/s, then providing the class to be used ingame
      def setup
        ensure_data_files_present
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

      def ensure_data_files_present
        return unless seed_incorrect?

        raise 'Game has not been seeded correctly! Please run `bundle exec rake seed` before playing.'
      end

      def seed_incorrect?
        ENV['DATA_SOURCE'] == 'data' && Dir["#{Dir.pwd}/data/**/*.yml"].count < 10
      end

      def display_welcome_message
        display_diagnostic_info
        display_introduction_to_game
      end

      def display_diagnostic_info
        sleep 0.25
        Screen.output('............................................')
        sleep 0.25
        Screen.output('Hello and Welcome to Adventures of avaLancHe - Working title I know!!')
        sleep 0.5
        Screen.output("Current Version #{VERSION}")
        sleep 0.5
        Screen.output('For now you are a Fighter, with 25HP.').blink
      end

      def display_introduction_to_game
        sleep 0.5
        Screen.output("Whilst you're here, let me give you the down-low. You're about to begin your quest")
        sleep 0.5
        Screen.output(
          'You are in Newtown, and as avaLancHe ... our intrepid explorer, you have spawned ' \
          'in our village to kill Several Monsters and then the boss - The Orc!'
        )
        Screen.output('Press any button to continue')
        $stdin.gets
        Screen.output('Happy gaming!')
      end
    end
  end
end
