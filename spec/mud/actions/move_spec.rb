# frozen_string_literal: true

RSpec.describe MUD::Actions::Move do
  before do
    switch_logging_to_temp_file
    allow(described_class).to receive(:connected_rooms) { connected_rooms }
  end

  let(:new_room_id) { 2 }

  describe '#north' do
    context 'with an available room' do
      let(:connected_rooms) { { 'north' => new_room_id } }

      it 'moves to the room' do
        expect { described_class.north }.to change { current_room_id }.to(new_room_id)
      end

      it 'informs the user they changed rooms' do
        described_class.north

        expect(log_lines).to include(/You went north/)
      end
    end

    context 'without an available room' do
      let(:connected_rooms) { {} }

      it 'does not move to the room' do
        expect { described_class.north }.not_to change { current_room_id }
      end
    end
  end

  def current_room_id
    MUD::Game.player.current_room.room_id
  end
end
