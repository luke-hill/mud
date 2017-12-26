# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { create(:room, :in_town) }

  describe 'a valid room' do
    it 'has a room id' do
      expect(room.room_id).to be_an Integer
    end

    it 'has a room type' do
      expect(room.room_type).to be_an Integer
    end

    it 'has a location' do
      expect(room.location).to be_an Integer
    end

    context 'has a default enemy' do
      it 'that exists' do
        expect(room.default_enemy).to be_an Integer
      end

      it 'with valid hp' do
        expect(room.enemy_hp).to be >= 0
      end
    end

    it 'has a description and advanced description' do
      expect(room.description.length).to be > 20

      expect(room.advanced_description.length).to be > 20
    end

    it 'saves to the database' do
      expect { room }.to change { Room.count }.by(1)
    end
  end

  describe 'an invalid room' do
    let(:room) { Room.create }
    let(:errors) { room.errors }

    it 'has no room id' do
      expect(errors).to have_key(:room_id)
    end

    it 'has no room type' do
      expect(errors).to have_key(:room_type)
    end

    it 'has no location' do
      expect(errors).to have_key(:location)
    end

    it 'has no default enemy' do
      expect(errors).to have_key(:default_enemy)
    end

    it 'has no description or advanced description' do
      expect(errors).to have_key(:description)

      expect(errors).to have_key(:advanced_description)
    end

    it 'does not save to the database' do
      expect { room }.not_to change { Room.count }
    end
  end
end
