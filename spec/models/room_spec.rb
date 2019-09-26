# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:rooms) { create(:room) }

  context 'with a valid room' do
    it { should validate_presence_of(:room_id) }

    it { should validate_presence_of(:room_type_id) }

    it { should validate_presence_of(:location_id) }

    it { should validate_presence_of(:enemy_id) }

    it { should validate_length_of(:description).is_at_least(20) }

    it { should validate_length_of(:advanced_description).is_at_least(20) }

    it 'saves to the database' do
      expect { room }.to change { Room.count }.by(1)
    end
  end

  context 'with an invalid room' do
    let(:rooms) { Room.create }
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
      expect(errors).to have_key(:enemy)
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
