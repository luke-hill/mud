require 'rails_helper'

RSpec.describe ActivePlayer, type: :model do
  describe '#move' do
    let(:player) { create(:player) }

    it 'calls the RoomController move methods cleanly' do
      skip 'Need a clean DSL of saying (Calls this method)'

      player.move('north')
      expect(RoomController.new).to receive(:north)
      player.move('north')

      #expect(player.move('north')).not_to raise_error
    end
  end
end
# Example
# game.instance_variable_set(:@counter, 8)
# game.increment_counter
# expect(game).to receive(:tie_game?)
