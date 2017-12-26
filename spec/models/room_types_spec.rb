# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomType, type: :model do
  let(:room_type) { create(:room_type) }

  describe 'a valid room type' do
    it 'has a name' do
      expect(room_type.name).to be_a String
    end

    it 'saves to the database' do
      expect { room_type }.to change { RoomType.count }.by(1)
    end
  end

  describe 'an invalid room' do
    let(:room_type) { RoomType.create }

    it 'has no name' do
      expect(room_type.errors).to have_key(:name)
    end

    it 'does not save to the database' do
      expect { room_type }.not_to change { RoomType.count }
    end
  end
end
