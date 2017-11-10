# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:invalid_room) { Room.create }
  let(:valid_room) { create(:room, :in_town, north: 3) }

  context 'a valid room' do
    it 'has a room id' do
      expect(valid_room.room_id).to be_an Integer
    end

    it 'saves to the database' do
      expect { valid_room }.to change { Room.count }.by(1)
    end
  end

  context 'an invalid room' do
    it 'must have a room id' do
      expect(invalid_room.errors).to have_key(:room_id)
    end

    it 'does not save to the database' do
      expect { invalid_room }.not_to change { Room.count }
    end
  end
end
