# frozen_string_literal: true

RSpec.describe MUD::Shop do
  let(:valid_shop) { create_shop('valid_shop') }
  let(:invalid_shop) { create_shop('invalid_shop') }
  let(:player) { MUD::Game.player }
  let(:shop_items_string) do
    <<~ITEMS
      --------------------
      | Potion | 50 gold |
      --------------------
    ITEMS
  end

  let(:presenter_instance) { instance_double(MUD::Presenters::ShopItems) }

  before do
    allow(MUD::Presenters::ShopItems).to receive(:new).with('valid_shop').and_return(presenter_instance)
    allow(presenter_instance).to receive(:string).and_return(shop_items_string)
  end

  describe '#buy' do
    it 'attempts to buy by delegating to the buy class' do
      expect(MUD::Actions::Buy).to receive(:new).with('knife', valid_shop).and_call_original

      valid_shop.buy('knife')
    end
  end

  describe '#items_for_sale' do
    it 'outputs to the screen the items for sale' do
      expect(MUD::Screen).to receive(:output).with(shop_items_string)

      valid_shop.items_for_sale
    end
  end

  it 'cannot have enemies in a shop' do
    expect { invalid_shop }.to raise_error(RuntimeError).with_message("There shouldn't be any enemies in shops!")
  end
end
