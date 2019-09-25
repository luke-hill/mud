class Room < ApplicationRecord
  validates :description, presence: true
  validates :advanced_description, presence: true
  validates :show_directions, presence: true
end
