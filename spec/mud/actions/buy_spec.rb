# frozen_string_literal: true

RSpec.describe MUD::Actions::Buy do
  let(:buy_instance) { described_class.new(item_id, create_shop('valid_shop')) }
  let(:gold) { 51 }
  let(:item_id) { 'demo_healing' }
  let(:max_inventory_size) { 10 }
  let(:player) { MUD::Game.player }

  before do
    player.gold = gold
    player.inventory = []
    player.max_inventory_size = max_inventory_size
  end

  describe '#buy' do
    subject(:buy_attempt) { buy_instance.buy }

    context "when the item_id isn't recognised as being for sale" do
      let(:item_id) { 'not_sold' }

      it "informs the player that the item isn't for sale" do
        expect(buy_attempt).to eq("I'm sorry we dont have that item for sale".red)
      end

      it "does not add the item to the player's inventory" do
        expect { buy_attempt }.not_to change(player, :inventory)
      end

      it "does not reduce the player's gold" do
        expect { buy_attempt }.not_to change(player, :gold)
      end
    end

    context "when the player doesn't have enough gold for the item_id" do
      let(:gold) { 49 }

      it "informs the player that they don't have enough gold" do
        expect(buy_attempt).to eq('You do not have enough gold for that.'.red)
      end

      it "does not add the item to the player's inventory" do
        expect { buy_attempt }.not_to change(player, :inventory)
      end

      it "does not reduce the player's gold" do
        expect { buy_attempt }.not_to change(player, :gold)
      end
    end

    context "when the player doesn't have enough space for the item_id" do
      let(:max_inventory_size) { 0 }

      it "informs the player that they don't have enough space" do
        expect(buy_attempt).to eq('You do not have enough space for that.'.red)
      end

      it "does not add the item to the player's inventory" do
        expect { buy_attempt }.not_to change(player, :inventory)
      end

      it "does not reduce the player's gold" do
        expect { buy_attempt }.not_to change(player, :gold)
      end
    end

    it "reduces the player's gold by the item_ids cost" do
      expect { buy_attempt }.to change(player, :gold).by(-50)
    end

    it "adds the item_id to the player's inventory" do
      expect { buy_attempt }.to change(player.inventory, :length).by(1)
    end

    it 'informs the player the player bought the item' do
      expect(buy_attempt).to eq("You bought a #{item_id.blue} for #{50.to_s.yellow} gold.")
    end
  end
end
