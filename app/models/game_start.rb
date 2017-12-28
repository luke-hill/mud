class GameStart

  include ApplicationHelper

  def begin
    create_game
    while alive?
      input = gets.chomp
      case input.split.first.to_s.downcase
      when 'north', 'n'
        current_player.move('north')
      when 'south', 's'
        current_player.move('south')
      else
        puts 'Input not yet recognised'
      end
    end
    game_quit
  end

  private

  def create_game
    Game.new
  end

  def alive?
    current_player.hp.positive?
  end

  def game_quit
    puts 'You died'
    sleep 2
    exit
  end
end

GameStart.new.begin
