# frozen_string_literal: true

RSpec.shared_examples 'Movement examples' do
  subject(:move_attempt) { described_class.new(direction).move }

  let(:player) { MUD::Game.player }

  context 'with an available room' do
    before do
      player.current_room = MUD::Room.new('blank_room')
    end

    it 'moves to the room' do
      expect { move_attempt }.to change { current_room_id }.to('filled_room')
    end

    it 'informs the user they changed rooms' do
      move_attempt

      expect(log_lines).to include(/You went #{direction}/)
    end
  end

  context 'without an available room' do
    before do
      player.current_room = MUD::Room.new('trapped_room')
    end

    it 'does not move to the room' do
      expect { move_attempt }.not_to(change { current_room_id })
    end
  end
end
