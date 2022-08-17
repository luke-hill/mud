# frozen_string_literal: true

RSpec.describe MUD::Shop do
  let(:shop) { described_class.new(room_id) }
  let(:shop_items_string) do
    <<~ITEMS
      --------------------
      | Potion | 50 gold |
      --------------------
    ITEMS
  end
  let(:room_id) { 1 }
  let(:item_id) { 'knife' }

  before do
    allow(shop).to receive(:shop_items_string).and_return(shop_items_string)
  end

  describe '#buy' do
    it 'attempts to buy by delegating to the buy class' do
      expect(MUD::Actions::Buy).to receive(:new).with(player, item_id).and_call_original

      shop.buy(item_id)
    end
  end

  describe '#items_for_sale' do
    it 'outputs to the screen the items for sale' do
      expect(MUD::Screen).to receive(:output).with(shop_items_string)

      shop.items_for_sale
    end
  end
end
