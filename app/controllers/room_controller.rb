class RoomController < ApplicationController
  include ApplicationHelper

  def look_around
    puts 'You look around the current room'
  end

  def north(position)
    find_room(position)

    if north_room
      puts 'You went North'
      puts north_room
      current_player.update(room_id: north_room)
    else
      puts 'No go'
    end
  end

  def south(position)
    find_room(position)

    if south_room
      puts 'You went South'
      puts south_room
      current_player.update(room_id: south_room)
    else
      puts 'No go'
    end
  end

  def east(position)
    find_room(position)

    if east_room
      puts 'You went East'
      puts east_room
      current_player.update(room_id: east_room)
    else
      puts 'No go'
    end
  end

  def west(position)
    find_room(position)

    if west_room
      puts 'You went West'
      puts west_room
      current_player.update(room_id: west_room)
    else
      puts 'No go'
    end
  end

  def up
    puts 'Move Up'
  end

  def down
    puts 'Move Down'
  end

  def pickup_item
    puts 'Picks up Item'
  end

  def drop_item
    puts 'Drops Item'
  end

  def pickup_gold
    puts 'Picks up gold'
  end

  private

  def north_room
    current_player.room.north
    #@room.north
  end

  def south_room
    @room.south
  end

  def east_room
    @room.east
  end

  def west_room
    @room.west
  end

  def find_room(room_id)
    @room ||= Room.find_by_room_id(room_id)
  end
end
