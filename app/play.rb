# frozen_string_literal: true

require_relative 'game'

module MUD
  class Play
    def play
      while player.alive?
        input = gets.chomp.split.first.to_s.downcase
        check_directional(input)
        check_miscellaneous(input)
        MUD::Screen.output('Input not yet recognised as a valid command')
      end
      die
    end

    private

    def player
      @player ||= MUD::Game.setup
    end

    def check_directional(input)
      case input[0]
      when 'n'; then player.move('north')
      when 's'; then player.move('south')
      when 'e';  then player.move('east')
      when 'w';  then player.move('west')
      when 'u';  then player.move('up')
      when 'd';  then player.move('down')
      else MUD::Logger.debug("This isn't a movement")
      end
    end

    def check_miscellaneous(input)
      case input
      when '';           then player.look_around
      when 'debug';      then output_diagnostic_info
      when 'quit', 'q';  then die
      else MUD::Logger.debug("This isn't a miscellaneous input")
      end
    end

    def output_diagnostic_info
      MUD::Logger.debug('... DEBUG DIAGNOSTIC DUMP...')
      MUD::Screen.output("Description is: #{player.current_room.description}")
      MUD::Screen.output("Advanced Description is: #{player.current_room.advanced_description}")
      MUD::Screen.output("Connected rooms #{player.current_room.connected_rooms}")
      MUD::Screen.output("Inventory: #{player.inventory}")
      MUD::Screen.output("Weapon: #{player.weapon.green}")
      MUD::Screen.output("Armor: #{player.armor.green}")
      MUD::Screen.output("Current Enemy in Room: #{player.current_room.enemy.inspect}")
      player.view_attributes
      MUD::Logger.debug('... END DEBUG DIAGNOSTIC DUMP...')
    end

    def die
      MUD::Screen.output('You died'.red)
      sleep 2
      exit
    end
  end
end

Play.new.play
