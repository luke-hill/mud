module ApplicationHelper
  def update_room(id)
    room = room(id)

    if room_unvisited_within_5_mins?(room)
      'Respawn, needs updating to n minutes'
    elsif room_clear?(room)
      'Clear'
    else
      'Monster'
    end
  end

  private

  def room_unvisited_within_5_mins?(room)
    room.updated_at < 5.minutes.ago
  end

  def room_clear?(room)
    room.enemy_hp.zero?
  end

  def room(room_id)
    Room.find_by_room_id(room_id)
  end
end
