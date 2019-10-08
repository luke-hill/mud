class Game
  attr_reader :player

  def initialize
    @player = Player::Avalanche.new
  end
end
