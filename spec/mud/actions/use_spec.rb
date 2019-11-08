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

    context "when the item_id is a valid healing potion" do
      let(:item_id) { 'lesser_healing_potion' }

      before { hero.hp = 10 }

      it "uses up the potion in the heroes inventory" do
        expect { use_attempt }.to change(hero, :inventory).from([item_id]).to([])
      end

      it "increases the heroes current hp" do
        expect { use_attempt }.to change(hero, :hp).from(10).to(20)
      end
    end

    context "when the item_id is `barracks_key`" do
      let(:item_id) { 'barracks_key' }

      it "uses up the barracks key in the heroes inventory" do
        expect { use_attempt }.to change(hero, :inventory).from([item_id]).to([])
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:@hero) }
  end
end
