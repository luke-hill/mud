require_relative 'app/game'

class Play
  def play
    while alive?
      input = gets.chomp
      case input.split.first.to_s.downcase
      when 'north', 'n'; then player.move('north')
      when 'south', 's'; then player.move('south')
      when 'east', 'e';  then player.move('east')
      when 'west', 'w';  then player.move('west')
      when '';           then output_diagnostic_info
      when 'quit', 'q';  then die
      else puts 'Input not yet recognised'
      end
    end
    die
  end

  private

  def alive?
    player.hp.positive?
  end

  def player
    @player ||= MUD::Game.setup
  end

  def output_diagnostic_info
    MUD::Logger.debug('Diagnostic info is...')
    MUD::Screen.output("Description is: #{player.current_room.description.blue}")
    MUD::Screen.output("Advanced Description is: #{player.current_room.description.blue}")
    MUD::Screen.output(player.connected_rooms)
  end

  def die
    MUD::Screen.output('You died'.red)
    sleep 2
    exit
  end
end

Play.new.play
