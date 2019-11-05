RSpec.shared_examples "Movement examples" do
  let(:move_direction) { described_class.send(direction) }

  context 'with an available room' do
    let(:connected_rooms) { { direction => new_room_id } }

    it 'moves to the room' do
      puts current_room_id
      expect { move_direction }.to change { current_room_id }.to(new_room_id)
      puts current_room_id
    end

    it 'informs the user they changed rooms' do
      move_direction

      expect(log_lines).to include(/You went #{direction}/)
    end
  end

  context 'without an available room' do
    let(:connected_rooms) { {} }

    it 'does not move to the room' do
      expect { move_direction }.not_to change { current_room_id }
    end
  end
end
