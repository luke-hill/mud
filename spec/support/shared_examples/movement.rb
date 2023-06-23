# frozen_string_literal: true

RSpec.shared_examples 'Movement examples' do
  subject(:move_attempt) { described_class.new(player, direction).move }

  let(:new_room_id) { 2 }

  context 'with an available room' do
    let(:connected_rooms) { { direction => new_room_id } }

    it 'moves to the room' do
      expect { move_attempt }.to change { current_room_id }.to(new_room_id)
    end

    it 'informs the user they changed rooms' do
      move_attempt

      expect(log_lines).to include(/You went #{direction}/)
    end
  end

  context 'without an available room' do
    let(:connected_rooms) { {} }

    it 'does not move to the room' do
      expect { move_attempt }.not_to(change { current_room_id })
    end
  end
end
