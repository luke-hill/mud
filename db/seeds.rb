Room.destroy_all
RoomType.destroy_all
Location.destroy_all
Enemy.destroy_all

require_relative 'room_types'
require_relative 'locations'
require_relative 'rooms' # Must be after `room_types`, `locations` and `enemies`
