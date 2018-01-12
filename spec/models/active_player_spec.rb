require 'rails_helper'

RSpec.describe ActivePlayer, type: :model do
  describe '#move' do
    let(:player) { create(:player) }

    it 'calls the RoomController move methods cleanly' do
      skip 'Also needs RSpec setting up in advance'

      expect(player.move('north')).not_to raise_error
    end

    #Below is a good starting point

    # describe 'Unimplemented Actions' do
    #   describe '#north' do
    #     let(:player) { create(:player) }
    #
    #     subject { player }
    #
    #     it "currently does nothing as it's not implemented" do
    #       p subject.room
    #
    #       expect(subject.north).to eq('Not in active use')
    #     end
    #   end
    # end
  end
end
