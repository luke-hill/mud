# frozen_string_literal: true

RSpec.describe MUD::DirectionsPresenter do
  let(:presenter) { described_class.new(double) }
  let(:visible_directions) { directions - hidden_directions }

  before do
    allow(presenter).to receive(:directions).and_return(directions)
    allow(presenter).to receive(:hidden_directions).and_return(hidden_directions)
  end

  describe '#string' do
    context 'with no hidden directions' do
      let(:hidden_directions) { [] }

      context 'with no visible directions' do
        let(:directions) { [] }

        it 'shows no directions' do
          expect(presenter.string).to eq('You cannot move in any direction')
        end
      end

      context 'with 1 visible direction' do
        let(:directions) { %w[north] }

        it 'calls `#visible_directions_as_string`' do
          expect(presenter).to receive(:visible_directions_as_string)

          presenter.string
        end

        it 'shows only the visible directions' do
          visible_directions.each do |direction|
            expect(presenter.string).to include(direction)
          end
        end
      end

      context 'with 2 visible directions' do
        let(:directions) { %w[north south] }

        it 'calls `#visible_directions_as_string`' do
          expect(presenter).to receive(:visible_directions_as_string)

          presenter.string
        end

        it 'shows only the visible directions' do
          visible_directions.each do |direction|
            expect(presenter.string).to include(direction)
          end
        end
      end
    end

    context 'with 1 hidden direction' do
      let(:hidden_directions) { %w[north] }

      context 'with no visible directions' do
        let(:directions) { [] }

        it 'shows no directions' do
          expect(presenter.string).to eq('You cannot move in any direction')
        end
      end

      context 'with 1 visible direction' do
        let(:directions) { %w[north] }

        it 'shows no directions' do
          expect(presenter.string).to eq('You cannot move in any direction')
        end
      end

      context 'with 2 visible directions' do
        let(:directions) { %w[north south] }

        it 'calls `#visible_directions_as_string`' do
          expect(presenter).to receive(:visible_directions_as_string)

          presenter.string
        end

        it 'shows only the visible directions' do
          visible_directions.each do |direction|
            expect(presenter.string).to include(direction)
          end
        end
      end
    end
  end
end
