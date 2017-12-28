class Game
  attr_reader :player

  def initialize
    wipe_all_previous_players
    set_player_attributes
    create_player_object
    assign_player_to_active_players
  end

  private

  def wipe_all_previous_players
    ActivePlayer.destroy_all
  end

  def set_player_attributes
    puts 'For now you must be a Fighter, with 10 Strength and 10 Agility'
  end

  def create_player_object
    @player ||= Fighter::Player.new
  end

  def assign_player_to_active_players
    ActivePlayer.create(player_params)
  end

  def player_params
    {
      name: player.name,
      max_hp: player.max_hp,
      hp: player.hp,
      level: player.level,
      stamina: player.stamina,
      experience: player.experience,
      gold: player.gold,
      room_id: player.room_id,
    }
  end
end
