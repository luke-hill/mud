module ApplicationHelper
  def room_class(id)
    room = Room.find_by_room_id(id)

    if room_unvisited_within_5_mins?(room)
      unexplored_class
    elsif room_clear?(room)
      room_cleared_class
    else
      monster_present_class
    end
  end

  def level_width
    5
  end

  def level_height
    5
  end

  private

  def room_unvisited_within_5_mins?(room)
    room.updated_at < 5.minutes.ago rescue false
  end

  def room_clear?(room)
    room.enemy_hp.zero? rescue true
  end

  def room_cleared_class
    'room__cleared-out'
  end

  def monster_present_class
    'room__monster-present'
  end

  def unexplored_class
    'room__unexplored'
  end
end
