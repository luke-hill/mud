# frozen_string_literal: true

RSpec.describe MUD::Presenters::ShopItems do
  let(:shop_items_presenter) { described_class.new(shop) }

  describe '#string' do
    context 'with 1 item for sale' do
      let(:shop) { create_shop('small_shop') }

      it 'will display a list formatted with just the single item' do
        expect(shop_items_presenter).to receive(:dashed_string).at_most(:twice)

        shop_items_presenter.string
      end
    end

    context 'with multiple items for sale' do
      let(:shop) { create_shop('valid_shop') }

      it 'will display a list formatted with all of the items' do
        expect(shop_items_presenter).to receive(:dashed_string).at_least(3).times

        shop_items_presenter.string
      end
    end
  end
end
