# frozen_string_literal: true

RSpec.describe MUD::Actions::Buy do
  subject(:buy_instance) { described_class.new(item_id, hero.current_room) }

  let(:hero) { MUD::Game.player }
  let(:item_id) { 'knife' }
  let(:for_sale?) { true }
  let(:enough_money?) { true }
  let(:enough_space?) { true }

  before do
    allow(buy_instance).to receive(:cost).and_return(1)
    allow(buy_instance).to receive(:for_sale?).and_return(for_sale?)
    allow(buy_instance).to receive(:enough_money?).and_return(enough_money?)
    allow(buy_instance).to receive(:enough_space?).and_return(enough_space?)
  end

  describe '#buy' do
    subject(:buy_attempt) { buy_instance.buy }

    context "when the item_id isn't recognised as being for sale" do
      let(:for_sale?) { false }

      it "informs the player that the item isn't for sale" do
        expect(buy_attempt).to eq("I'm sorry we dont have that item for sale".red)
      end

      it "does not add the item to the hero's inventory" do
        expect { buy_attempt }.not_to change(hero, :inventory)
      end

      it "does not reduce the hero's gold" do
        expect { buy_attempt }.not_to change(hero, :gold)
      end
    end

    context "when the hero doesn't have enough gold for the item_id" do
      let(:enough_money?) { false }

      it "informs the player that they don't have enough gold" do
        expect(buy_attempt).to eq('You do not have enough gold for that.'.red)
      end

      it "does not add the item to the hero's inventory" do
        expect { buy_attempt }.not_to change(hero, :inventory)
      end

      it "does not reduce the hero's gold" do
        expect { buy_attempt }.not_to change(hero, :gold)
      end
    end

    context "when the hero doesn't have enough space for the item_id" do
      let(:enough_space?) { false }

      it "informs the player that they don't have enough space" do
        expect(buy_attempt).to eq('You do not have enough space for that.'.red)
      end

      it "does not add the item to the hero's inventory" do
        expect { buy_attempt }.not_to change(hero, :inventory)
      end

      it "does not reduce the hero's gold" do
        expect { buy_attempt }.not_to change(hero, :gold)
      end
    end

    it "reduces the hero's gold by the item_ids cost" do
      expect { buy_attempt }.to change(hero, :gold).by(-1)
    end

    it "adds the item_id to the hero's inventory" do
      expect { buy_attempt }.to change(hero.inventory, :length).by(1)
    end

    it 'informs the player the hero bought the item' do
      expect(buy_attempt).to eq("You bought a #{item_id.blue} for #{1.to_s.yellow} gold.")
    end
  end
end
