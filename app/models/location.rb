class Location < ApplicationRecord
  validates_presence_of :area

  has_many :rooms
end
