class RoomController < ApplicationController
  def look_around
    puts 'You look around the current room'
  end

  def north
    puts 'Move North'
  end

  def south
    puts 'Move South'
  end

  def east
    puts 'Move East'
  end

  def west
    puts 'Move West'
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
end
