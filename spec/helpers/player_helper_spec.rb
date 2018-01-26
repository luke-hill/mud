require 'rails_helper'

RSpec.describe PlayerHelper, type: :helper do
  describe '#current_player' do
    it 'returns the Active Player' do
      Game.new

      expect(current_player).to be_an(ActivePlayer)
    end
  end
end
