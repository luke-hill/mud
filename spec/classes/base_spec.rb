RSpec.describe MUD::Classes::Base do
  before do
    allow($stdout).to receive(:write).and_return nil
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(subject.current_room).to be_a MUD::Room
    end

    it 'is room 1 when starting a game' do
      expect(subject.current_room.room_id).to eq(1)
    end
  end
end
