class Game
  attr_reader :player

  def initialize
    set_player_attributes
    create_player_object
  end

  private

  def set_player_attributes
    puts 'For now you must be a Fighter, with 10 Strength and 10 Agility'
    puts 'For now your name will be Test'
  end

  def create_player_object
    @player ||= Fighter::Player.new('Test')
  end
end
