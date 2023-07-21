# frozen_string_literal: true

module MUD
  module Actions
    # This provides the middleware between input commands from the user console and the game
    # models and other actions.
    #
    # The single public method +process+ will attempt to read the command and then go through
    # a whitelist of expected inputs. If it matches one it will then process it.
    #
    # If the command isn't understood, it will show a message telling the user to try again.
    class Command
      attr_reader :command_input

      include Helpers::Data
      include Helpers::Methods
      include Helpers::Unnabbreviater

      def initialize(command_input)
        @command_input = command_input
      end

      # @return [String]
      # This method will process the command and either
      # Perform the command (and return the output)
      # Return a "Input not yet recognised as a valid command"
      def process
        Logger.debug("Raw input received from user: '#{command_input}'")
        return player.fight if attack?
        return process_miscellaneous if miscellaneous?
        return process_compass_direction if compass_direction?

        Screen.output('Input not yet recognised as a valid command')
      end

      private

      def attack?
        %w[a attack].include?(command_input)
      end

      def process_miscellaneous
        case command_input
        when '';           then player.look_around
        when 'debug';      then output_diagnostic_info
        else die
        end
      end

      def miscellaneous?
        ['', 'debug', 'quit'].include?(command_input)
      end

      def process_compass_direction
        player.move(unnabbreviate(command_input, type: :movement))
      end

      def compass_direction?
        %w[n north s south w west e east u up d down].include?(command_input)
      end

      def output_diagnostic_info
        Logger.debug('... DEBUG DIAGNOSTIC DUMP...')
        output_room_data
        output_player_data
        Screen.output("Current Enemy in Room: #{player.current_room.enemy.inspect}")
        Logger.debug('... END DEBUG DIAGNOSTIC DUMP...')
      end

      def output_room_data
        Screen.output("Description is: #{player.current_room.description}")
        Screen.output("Advanced Description is: #{player.current_room.advanced_description}")
        Screen.output("Connected rooms #{player.current_room.connected_rooms}")
      end

      def output_player_data
        Screen.output("Inventory: #{player.inventory.to_s.green}")
        Screen.output("Weapon: #{player.weapon.name.green}")
        Screen.output("Armor: #{player.armor.name.green}")
        player.view_attributes
      end

      def die
        Screen.output('You died'.red)
        exit
      end
    end
  end
end
