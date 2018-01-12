class RoomController < ApplicationController
  include ApplicationHelper

  def look_around
    'Not implemented yet'
  end

  def north
    if north_room
      current_player.update(room_id: north_room)
      'You went North'
    else
      'No go'
    end
  end

  def south
    if south_room
      current_player.update(room_id: south_room)
      'You went South'
    else
      'No go'
    end
  end

  def east
    if east_room
      current_player.update(room_id: east_room)
      'You went East'
    else
      'No go'
    end
  end

  def west
    if west_room
      current_player.update(room_id: west_room)
      'You went West'
    else
      'No go'
    end
  end

  def up
    'Not in active use'
  end

  def down
    'Not in active use'
  end

  def pickup_item
    'Not in active use'
  end

  def drop_item
    'Not in active use'
  end

  def pickup_gold
    'Not in active use'
  end

  def drop_gold
    'Not in active use'
  end

  private

  def north_room
    current_player.room.north
  end

  def south_room
    current_player.room.south
  end

  def east_room
    current_player.room.east
  end

  def west_room
    current_player.room.west
  end
end
