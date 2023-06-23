# frozen_string_literal: true

RSpec.describe MUD::Room do
  let(:room) { described_class.new(room_id) }
  let(:description_yml) do
    {
      room_id => {
        'description' => 'Description HERE',
        'advanced_description' => 'Advanced Description HERE'
      }
    }
  end
  let(:direction_yml) do
    {
      room_id => {
        'north' => 2,
        'south' => 3,
        'east' => 4
      }
    }
  end
  let(:directions_string) { 'You can go north, south and east' }
  let(:room_id) { 1 }

  before do
    allow(room).to receive(:description_yml).and_return(description_yml)
    allow(room).to receive(:directions_string).and_return(directions_string)
    allow(room).to receive(:direction_yml).and_return(direction_yml)
  end

  describe '#description' do
    it 'returns the description of the room first' do
      expect(room.description).to start_with('Description HERE'.blue)
    end

    it 'returns the directions after the description' do
      expect(room.description).to end_with(directions_string.yellow)
    end
  end

  describe '#advanced_description' do
    it 'returns the advanced description of the room first' do
      expect(room.advanced_description).to start_with('Advanced Description HERE'.blue)
    end

    it 'returns the directions after the advanced description' do
      expect(room.advanced_description).to end_with(directions_string.yellow)
    end
  end

  describe '#visit' do
    it 'outputs to the screen that you have visited the room' do
      expect(MUD::Screen).to receive(:output).with(room.description)

      room.visit
    end

    it 'increases the visited count by 1' do
      expect { room.visit }.to change(room, :times_visited).by(1)
    end
  end

  describe '#leave' do
    it 'updates the global `rooms_visited`' do
      expect { room.leave }.to change(MUD::Game.player, :rooms_visited)
    end
  end

  describe '#connected_rooms' do
    subject { room.connected_rooms }

    it { is_expected.to eq('north' => 2, 'south' => 3, 'east' => 4) }
  end

  describe '#enemy?' do
    subject { room.enemy? }

    let(:enemy_hp) { 5 }

    before do
      allow(room.enemy).to receive(:hp).and_return(enemy_hp)
    end

    context 'when there is an alive enemy in the room' do
      it { is_expected.to be true }
    end

    context 'when there is a dead enemy in the room' do
      let(:enemy_hp) { 0 }

      it { is_expected.to be false }
    end

    context 'when there is no enemy in the room' do
      before do
        allow(room.enemy).to receive(:id).and_return('no_enemy')
      end

      it { is_expected.to be false }
    end
  end

  describe '#exitable?' do
    subject { room.exitable? }

    before do
      allow(room).to receive(:ktp?).and_return(ktp?)
      allow(room).to receive(:enemy?).and_return(enemy?)
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
