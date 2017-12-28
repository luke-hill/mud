class Room < ApplicationRecord
  validates_presence_of :room_id,
                        :room_type_id,
                        :location_id,
                        :description,
                        :advanced_description

  has_one :room_type, primary_key: :room_type_id, foreign_key: :id
  has_one :location, primary_key: :location_id, foreign_key: :id
  has_one :enemy, primary_key: :enemy_id, foreign_key: :id
end
