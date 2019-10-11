class Play
  def play
    require_relative 'app/game'

    while alive?
      input = gets.chomp
      case input.split.first.to_s.downcase
      when 'north', 'n'
        player.move('north')
      when 'south', 's'
        player.move('south')
      when 'east', 'e'
        player.move('north')
      when 'west', 'w'
        player.move('south')
      else
        puts 'Input not yet recognised'
      end
    end
    quit
  end

  private

  def game
    MUD::Game.instance
  end

  def player
    game.player
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

Play.new.play
