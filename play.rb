require_relative 'app/game'

class Play
  def play
    while alive?
      input = gets.chomp
      case input.split.first.to_s.downcase
      when 'north', 'n'
        player.move('north')
      when 'south', 's'
        player.move('south')
      when 'east', 'e'
        player.move('east')
      when 'west', 'w'
        player.move('west')
      else
        puts 'Input not yet recognised'
      end
    end
    quit
  end

  private

  def player
    @player ||= MUD::Game.setup
  end

  def alive?
    player.hp.positive?
  end

  def quit
    Screen.output('You died')
    sleep 2
    exit
  end
end

p = Play.new
p.send(:player).move('north')