class Room < ApplicationRecord
  validates_presence_of :room_id,
                        :room_type_id,
                        :location_id,
                        :enemy_id

  validates :enemy_hp, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { minimum: 20 }
  validates :advanced_description, length: { minimum: 20 }

  belongs_to :room_type
  belongs_to :location
  belongs_to :enemy
end
