class RoomType < ApplicationRecord
  validates_presence_of :name

  has_many :rooms
end
