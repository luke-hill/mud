# frozen_string_literal: true

RSpec.describe MUD::Actions::Use do
  subject(:use_instance) { described_class.new(item_id) }

  let(:player) { MUD::Game.player }
  let(:item_id) { 'demo_healing' }

  before do
    player.inventory << item_id
  end

  describe '#use' do
    subject(:use_attempt) { use_instance.use }

    context "when the item_id isn't recognised as being usable" do
      let(:item_id) { 'unknown_item' }

      it "informs the player that the item isn't usable" do
        expect(use_attempt).to eq('You cannot use this item!'.red)
      end

      it 'does not use the item up' do
        expect { use_attempt }.not_to change(player, :inventory)
      end
    end

    context "when the player doesn't have the item_id in his inventory" do
      before { reset_inventory }

      it "informs the player that they don't have enough gold" do
        expect(use_attempt).to eq("You do not have a #{item_id}".red)
      end

      it 'does not use the item up' do
        expect { use_attempt }.not_to change(player, :inventory)
      end
    end

    context 'when the item_id is a valid potion' do
      let(:item_id) { 'demo_healing' }

      before { player.hp = 10 }

      it 'uses up the potion in the players inventory' do
        expect { use_attempt }.to change(player.inventory, :length).by(-1)
      end

      it 'increases the players current hp' do
        expect { use_attempt }.to change(player, :hp).from(10).to(20)
      end
    end

    context 'when the item_id is a valid key' do
      let(:item_id) { 'dummy' }

      it 'uses up the key in the playeres inventory' do
        expect { use_attempt }.to change(player.inventory, :length).by(-1)
      end
    end
  end
end
