require_relative 'app/game'

class Play
  def play
    while player.alive?
      input = gets.chomp
      case input.split.first.to_s.downcase
      when 'north', 'n'; then player.move('north')
      when 'south', 's'; then player.move('south')
      when 'east', 'e';  then player.move('east')
      when 'west', 'w';  then player.move('west')
      when '';           then player.look_around
      when 'debug';      then output_diagnostic_info
      when 'quit', 'q';  then die
      else puts 'Input not yet recognised'
      end
    end
    die
  end

  private

  def player
    @player ||= MUD::Game.setup
  end

  def output_diagnostic_info
    MUD::Logger.debug('... DEBUG DIAGNOSTIC DUMP...')
    MUD::Screen.output("Description is: #{player.current_room.description}")
    MUD::Screen.output("Advanced Description is: #{player.current_room.advanced_description}")
    MUD::Screen.output(player.current_room.connected_rooms)
    player.view_attributes
  end

  def die
    MUD::Screen.output('You died'.red)
    sleep 2
    exit
  end
end

Play.new.play
