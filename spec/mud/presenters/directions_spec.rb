# frozen_string_literal: true

RSpec.describe MUD::Presenters::Directions do
  let(:trapped_room_presenter) { described_class.new(direction_yml['trapped_room']) }
  let(:corridor_presenter) { described_class.new(direction_yml['corridor']) }
  let(:open_room_presenter) { described_class.new(direction_yml['blank_room']) }

  describe '#string' do
    context 'with no hidden directions' do
      it 'can show no directions' do
        expect(trapped_room_presenter.string).to eq('You cannot move in any direction')
      end

      it 'can show a single direction when visible' do
        expect(corridor_presenter.string).to eq('You can only go north')
      end

      it 'can show multiple directions when visible' do
        expect(open_room_presenter.string).to eq('You can go north, east, south, west, up and down')
      end
    end

    context 'with hidden directions' do
      before do
        allow(trapped_room_presenter).to receive(:hidden_directions).and_return(%w[north south])
        allow(corridor_presenter).to receive(:hidden_directions).and_return(%w[north south])
        allow(open_room_presenter).to receive(:hidden_directions).and_return(%w[north south])
      end

      it 'can show no directions' do
        expect(trapped_room_presenter.string).to eq('You cannot move in any direction')
      end

      it 'shows no directions when a single direction is invisible' do
        expect(corridor_presenter.string).to eq('You cannot move in any direction')
      end

      it 'shows only visible directions when some directions are invisible' do
        expect(open_room_presenter.string).to eq('You can go east, west, up and down')
      end
    end

    context 'with too many directions' do
      before do
        allow(open_room_presenter.directions).to receive(:keys).and_return(%w[north east south west up down left right])
      end

      it 'will just show the standard 6 directions show no directions' do
        expect(open_room_presenter.string).to eq('You can go north, east, south, west, up and down')
      end
    end
  end
end
