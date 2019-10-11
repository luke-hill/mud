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

  def alive?
    player.hp.positive?
  end

  def die
    MUD::Screen.output('You died'.red)
    sleep 2
    exit
  end
end

Play.new.play
