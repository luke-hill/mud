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

      def initialize(command_input)
        @command_input = command_input
      end

      # @return [String]
      # This method will process the command and either
      # Perform the command (and return the output)
      # Return a "Input not yet recognised as a valid command"
      def process
        MUD::Logger.debug("Raw input received from user: '#{command_input}'")
        return process_attack if attack?
        return process_miscellaneous if miscellaneous?
        return process_north_south_east_west if compass_direction?
        return process_up_down if up_or_down?

        MUD::Screen.output('Input not yet recognised as a valid command')
      end

      private

      def process_attack
        case command_input
        when 'a', 'attack'; then player.fight
        else                raise "Unreachable code - Command Input: #{command_input}"
        end
      end

      def attack?
        %w[a attack].include?(command_input)
      end

      def process_miscellaneous
        case command_input
        when '';           then player.look_around
        when 'debug';      then output_diagnostic_info
        when 'quit';       then die
        else               raise "Unreachable code - Command Input: #{command_input}"
        end
      end

      def miscellaneous?
        ['', 'debug', 'quit'].include?(command_input)
      end

      def process_north_south_east_west
        player.move(command_input)
      end

      def compass_direction?
        %w[n north s south w west e east].include?(command_input)
      end

      def process_up_down
        case command_input[0]
        when 'u', 'd'; then player.move(command_input[0])
        else           raise "Unreachable code - Command Input: #{command_input}"
        end
      end

      def up_or_down?
        %w[u up d down].include?(command_input)
      end

      def output_diagnostic_info
        MUD::Logger.debug('... DEBUG DIAGNOSTIC DUMP...')
        output_room_data
        output_player_data
        MUD::Screen.output("Current Enemy in Room: #{player.current_room.enemy.inspect}")
        MUD::Logger.debug('... END DEBUG DIAGNOSTIC DUMP...')
      end

      def output_room_data
        MUD::Screen.output("Description is: #{player.current_room.description}")
        MUD::Screen.output("Advanced Description is: #{player.current_room.advanced_description}")
        MUD::Screen.output("Connected rooms #{player.current_room.connected_rooms}")
      end

      def output_player_data
        MUD::Screen.output("Inventory: #{player.inventory}")
        MUD::Screen.output("Weapon: #{player.weapon.green}")
        MUD::Screen.output("Armor: #{player.armor.green}")
        player.view_attributes
      end

      def die
        MUD::Screen.output('You died'.red)
        sleep 2
        exit
      end
    end
  end
end
