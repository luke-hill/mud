# frozen_string_literal: true

RSpec.describe MUD::Room do
  let(:room) { described_class.new(room_id) }
  let(:description_yml) do
    {
      1 => {
        'description' => description_data,
        'advanced_description' => advanced_description_data
      }
    }
  end
  let(:direction_yml) do
    {
      1 => {
        'north' => 2,
        'south' => 3,
        'east' => 4
      }
    }
  end
  let(:description_data) { 'Desc' }
  let(:advanced_description_data) { 'Adv Desc' }
  let(:directions_string) { 'You can go north, south and east' }
  let(:player) { MUD::Game.player }
  let(:room_id) { 1 }

  before do
    allow(room).to receive(:description_yml).and_return(description_yml)
    allow(room).to receive(:directions_string).and_return(directions_string)
    allow(room).to receive(:direction_yml).and_return(direction_yml)
  end

  describe '#description' do
    let(:description) { room.description.split("\n").first }
    let(:directions) { room.description.split("\n").last }

    it 'returns the description of the room first' do
      expect(description).to eq(description_data.blue)
    end

    it 'returns the directions after the description' do
      expect(directions).to eq(directions_string.yellow)
    end
  end

  describe '#advanced_description' do
    let(:description) { room.advanced_description.split("\n").first }
    let(:directions) { room.advanced_description.split("\n").last }

    it 'returns the advanced description of the room first' do
      expect(description).to eq(advanced_description_data.blue)
    end

    it 'returns the directions after the advanced description' do
      expect(directions).to eq(directions_string.yellow)
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
      expect { room.leave }.to change(player, :rooms_visited)
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
