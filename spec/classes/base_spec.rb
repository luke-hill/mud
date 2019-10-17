RSpec.describe MUD::Classes::Base do
  before do
    # Stop console spam
    allow($stdout).to receive(:write).and_return nil

    # Mock sample player
    allow(player).to receive(:attributes).and_return(starting_attributes)
  end

  before(:each) do
    switch_logging_to_temp_file
  end

  after(:each) { remove_test_screen_logs }

  let(:starting_attributes) do
    {
      name: 'Test Player',
      max_hp: 25,
      hp: 25,
      stamina: 1,
      level: 1,
      experience: 0,
      gold: 200,
      inventory: []
    }
  end
  let(:player) { described_class.new }

  describe '#view_attributes' do
    it 'logs the relevant attribute information to the game console' do
      expect(log_lines).to be >= 8
    end
  end

  describe '#alive?' do
    subject { player.alive? }

    context 'when a player has more than 0 hp' do
      it { is_expected.to be true }
    end

    context 'when a player has 0 hp' do
      before { allow(player).to receive(:hp).and_return(0) }

      it { is_expected.to be false }
    end
  end

  describe '#move' do
    it 'delegates to the Movement::Move class' do
      expect(MUD::Movement::Move).to receive(:south)

      player.move('south')
    end
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(subject.current_room).to be_a MUD::Room
    end

    it 'is room 1 when starting a game' do
      expect(subject.current_room.room_id).to eq(1)
    end
  end

  describe '#current_room=' do
    it 'can update the current_room' do
      expect(subject).to respond_to(:current_room=)
    end
  end

  describe '#rooms_visited' do
    it 'returns what rooms you have visited' do
      expect(subject.rooms_visited).to be_a Hash
    end

    it 'is blank when starting a game' do
      expect(subject.rooms_visited).to eq({})
    end
  end

  describe '#rooms_visited=' do
    it 'can update the rooms you have visited' do
      expect(subject).to respond_to(:rooms_visited=)
    end
  end
end
