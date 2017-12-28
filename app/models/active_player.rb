class ActivePlayer < ApplicationRecord
  has_one :room, primary_key: :room_id, foreign_key: :room_id

  def move(direction)
    RoomController.new.send(direction, room_id)
  end

end
