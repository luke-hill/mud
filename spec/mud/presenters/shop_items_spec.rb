# frozen_string_literal: true

RSpec.describe MUD::Presenters::ShopItems do
  subject(:shop_items_presenter) { described_class.new(shop) }

  let(:dashed_regex) { /-{10,}/ }
  let(:word_regex) { /\|.+\|.+\|/ }

  describe '#string' do
    context 'with 1 item for sale' do
      let(:shop) { create_shop('small_shop') }

      it 'will display a list formatted with just the single item' do
        expect(shop_items_presenter.string).to match(/\A#{dashed_regex}\n#{word_regex}\n#{dashed_regex}\z/)
      end
    end

    context 'with multiple items for sale' do
      let(:shop) { create_shop('valid_shop') }

      it 'will display a list formatted with all of the items' do
        expect(shop_items_presenter.string).to match(/\A#{dashed_regex}\n#{word_regex}\n#{dashed_regex}\n#{word_regex}\n#{dashed_regex}\z/)
      end
    end
  end
end
