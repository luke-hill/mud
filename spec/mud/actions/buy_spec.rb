# frozen_string_literal: true

RSpec.describe MUD::Actions::Buy do
  subject(:buy_class) { described_class.new(hero, item_id) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:item_id) { 'knife' }
  let(:item_cost) { 1 }
  let(:initial_gold) { hero.gold }

  describe '#buy' do
    subject(:buy_item) { buy_class.buy }
    
    before do
      allow(buy_class).to receive(:cost).and_return(item_cost)
      swallow_console_spam
    end
    
    context "when the item_id isn't recognised as being for sale" do
      before { allow(buy_class).to receive(:for_sale?).and_return(false) }

      it "informs the player that the item isn't for sale" do
        expect(buy_item).to eq("I'm sorry we dont have that item for sale".yellow)
      end
    end

    context "when the hero doesn't have enough gold for the item_id" do
      before { allow(buy_class).to receive(:enough_money?).and_return(false) }

      it "informs the player that they don't have enough gold" do
        expect(buy_item).to eq('You do not have enough gold for that.'.red)
      end
    end

    context "when the hero doesn't have enough space for the item_id" do
      before { allow(buy_class).to receive(:enough_space?).and_return(false) }

      it "informs the player that they don't have enough space" do
        expect(buy_item).to eq('You do not have enough space for that.'.red)
      end
    end

    it "reduces the hero's gold by the item_ids cost" do
      expect { buy_item }.to change { hero.gold }.from(initial_gold).to(initial_gold - item_cost)
    end

    it "adds the item_id to the hero's inventory" do
      expect { buy_item }.to change { hero.inventory }.from([]).to([item_id])
    end

    it "informs the player the hero bought the item" do
      expect(buy_item).to eq("You bought a #{item_id.blue} for #{item_cost.to_s.yellow} gold.")
    end
  end

  describe "delegated methods" do
    it { should delegate(:inventory).to(:@hero) }
    it { should delegate(:gold).to(:@hero) }
    it { should delegate(:gold=).with(1).to(:@hero) }
    it { should delegate(:max_inventory_size).to(:@hero) }
  end
end
