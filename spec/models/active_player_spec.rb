require 'rails_helper'

RSpec.describe ActivePlayer, type: :model do
  describe '#move' do
    let(:player) { create(:player) }

    it 'calls the RoomController move methods cleanly' do
      skip 'Also needs RSpec setting up in advance'

      expect(player.move('north')).not_to raise_error
    end
  end
end
