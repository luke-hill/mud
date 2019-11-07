# frozen_string_literal: true

RSpec.describe MUD::Actions::Use do
  subject(:use_instance) { described_class.new(hero, item_id) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:item_id) { 'lesser_healing_potion' }
  let(:not_a_weapon) { 'unknown' }

  before do
    swallow_console_spam
    hero.inventory << item_id
    allow(MUD::Game).to receive(:player).and_return(hero)
  end

  describe '#use' do
    subject(:use_attempt) { use_instance.use }

    context "when the item_id isn't recognised as being usable" do
      before { allow(use_instance).to receive(:usable?).and_return(false) }

      it "informs the player that the item isn't for sale" do
        expect(use_attempt).to eq('You cannot use this item!'.red)
      end

      it "does not use the item up" do
        expect { use_attempt }.not_to change(hero, :inventory)
      end
    end

    context "when the hero doesn't have the item_id in his inventory" do
      before { allow(use_instance).to receive(:in_inventory?).and_return(false) }

      it "informs the player that they don't have enough gold" do
        expect(use_attempt).to eq("You do not have a #{item_id}".red)
      end

      it "does not use the item up" do
        expect { use_attempt }.not_to change(hero, :inventory)
      end
    end

    context "when the item_id is a valid potion" do
      let(:item_id) { 'lesser_healing_potion' }

      it "uses up the potion hero's inventory" do
        expect { use_attempt }.to change(hero, :inventory).from([item_id]).to([])
      end

      it "does not reduce the hero's gold" do
        expect { use_attempt }.not_to change(hero, :gold)
      end
    end

    it "reduces the hero's gold by the item_ids cost" do
      expect { use_attempt }.to change(hero, :gold).from(initial_gold).to(initial_gold - item_cost)
    end

    it "adds the item_id to the hero's inventory" do
      expect { use_attempt }.to change(hero, :inventory).from([]).to([item_id])
    end

    it 'informs the player the hero bought the item' do
      expect(buy_attempt).to eq("You bought a #{item_id.blue} for #{item_cost.to_s.yellow} gold.")
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:@hero) }
  end
end
