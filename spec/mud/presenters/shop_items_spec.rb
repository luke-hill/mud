# frozen_string_literal: true

RSpec.describe MUD::Presenters::ShopItems do
  subject(:shop_items_presenter) { described_class.new(shop) }

  describe '#string' do
    context 'with no items for sale' do
      let(:shop) { create_shop('empty_shop') }

      it 'will inform the user no items are for sale' do
        expect(shop_items_presenter.string).to eq('There are no potions for sale here yet.... Maybe wait for weapons?!'.blue)
      end
    end

    context 'with 1 item for sale' do
      let(:shop) { create_shop('small_shop') }

      it 'will display a list formatted with just the single item' do
        expect(shop_items_presenter.string.lines.length).to eq(3)
      end
    end

    context 'with multiple items for sale' do
      let(:shop) { create_shop('valid_shop') }

      it 'will display a list formatted with all of the items' do
        expect(shop_items_presenter.string.lines.length).to be >= 5
      end
    end
  end
end
