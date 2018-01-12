# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { create(:location) }

  describe 'a valid location' do
    it { should validate_presence_of(:area) }

    it 'saves to the database' do
      expect { location }.to change { Location.count }.by(1)
    end
  end

  describe 'an invalid location' do
    let(:location) { Location.create }

    it 'must have an area' do
      expect(location.errors).to have_key(:area)
    end

    it 'does not save to the database' do
      expect { location }.not_to change { Location.count }
    end
  end
end
