module RoomHelper
  def update_room
    return 'Unimplemented'

    if room_unvisited_within_5_mins?
      'Respawn, needs updating to n minutes'
    elsif room_clear?
      'Clear'
    else
      'Monster'
    end
  end

  private

  def room_unvisited_within_5_mins?
    room.updated_at < 5.minutes.ago
  end

  def room_clear?
    room.enemy_hp.zero?
  end

  def room
    current_player.room
  end
end
