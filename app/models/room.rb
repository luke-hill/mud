class Room < ApplicationRecord
  validates_presence_of :room_id,
                        :room_type,
                        :location,
                        :default_enemy,
                        :description,
                        :advanced_description
end
