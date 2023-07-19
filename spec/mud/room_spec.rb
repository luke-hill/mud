# frozen_string_literal: true

RSpec.describe MUD::Room do
  let(:filled_room) { create_room('filled_room') }
  let(:blank_room) { create_room('blank_room') }
  let(:trashed_room) { create_room('trashed_room') }

  describe '#description' do
    it 'returns the description of the room first' do
      expect(filled_room.description).to start_with('This is a busy room outside town')
    end

    it 'includes a reference to what enemy is present' do
      expect(filled_room.description).to include('TEST - Bad Enemy is here with you.')
    end

    it 'returns the directions after the description' do
      expect(filled_room.description).to end_with('You can go north, east, south and west'.yellow)
    end
  end

  describe '#advanced_description' do
    it 'returns the advanced description of the room first' do
      expect(filled_room.advanced_description).to start_with('This is dangerous!')
    end

    it 'includes a reference to what enemy is present' do
      expect(filled_room.advanced_description).to include('TEST - Bad Enemy is here with you.')
    end

    it 'returns the directions after the advanced description' do
      expect(filled_room.advanced_description).to end_with('You can go north, east, south and west'.yellow)
    end
  end

  describe '#enter' do
    it 'outputs to the screen that you have entered the room' do
      expect(MUD::Screen).to receive(:output).with(filled_room.description)

      filled_room.enter
    end

    it 'increases the visited count by 1' do
      expect { filled_room.enter }.to change(filled_room, :times_visited).by(1)
    end
  end

  describe '#leave' do
    it 'updates the global `rooms_visited`' do
      expect { filled_room.leave }.to change(MUD::Game.player, :rooms_visited)
    end
  end

  describe '#connected_rooms' do
    it 'outputs a list of all connected room ids' do
      expect(filled_room.connected_rooms).to be_a Hash
    end
  end

  describe '#enemy?' do
    it 'is true when there is an alive enemy in the room' do
      expect(filled_room.enemy?).to be true
    end

    it 'is false when there is a dead enemy in the room' do
      expect(trashed_room.enemy?).to be false
    end

    it 'is false when there is no enemy in the room' do
      expect(blank_room.enemy?).to be false
    end
  end

  describe '#exitable?' do
    subject { filled_room.exitable? }

    before do
      allow(filled_room).to receive(:ktp?).and_return(ktp?)
      allow(filled_room).to receive(:enemy?).and_return(enemy?)
    end

    context 'when the room has an enemy that is kill-to-pass' do
      let(:ktp?) { true }
      let(:enemy?) { true }

      it { is_expected.to be false }
    end

    context 'when the room has an enemy that is not kill-to-pass' do
      let(:ktp?) { false }
      let(:enemy?) { true }

      it { is_expected.to be true }
    end

    context 'when the room is kill-to-pass but there is no alive enemy' do
      let(:ktp?) { true }
      let(:enemy?) { false }

      it { is_expected.to be true }
    end

    context 'when the room is not kill-to-pass and there is no alive enemy' do
      let(:ktp?) { false }
      let(:enemy?) { false }

      it { is_expected.to be true }
    end
  end
end
