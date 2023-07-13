# frozen_string_literal: true

RSpec.describe MUD::Actions::Use do
  subject(:use_instance) { described_class.new(hero, item_id) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:item_id) { 'demo_healing' }

  before do
    hero.inventory << item_id
    allow(MUD::Game).to receive(:player).and_return(hero)
  end

  describe '#use' do
    subject(:use_attempt) { use_instance.use }

    context "when the item_id isn't recognised as being usable" do
      let(:item_id) { 'unknown_item' }

      it "informs the player that the item isn't usable" do
        expect(use_attempt).to eq('You cannot use this item!'.red)
      end

      it 'does not use the item up' do
        expect { use_attempt }.not_to change(hero, :inventory)
      end
    end

    context "when the hero doesn't have the item_id in his inventory" do
      before { hero.inventory = [] }

      it "informs the player that they don't have enough gold" do
        expect(use_attempt).to eq("You do not have a #{item_id}".red)
      end

      it 'does not use the item up' do
        expect { use_attempt }.not_to change(hero, :inventory)
      end
    end

    context 'when the item_id is a valid healing potion' do
      let(:item_id) { 'demo_healing' }

      before { hero.hp = 10 }

      it 'uses up the potion in the heroes inventory' do
        expect { use_attempt }.to change(hero.inventory, :length).by(-1)
      end

      it 'increases the heroes current hp' do
        expect { use_attempt }.to change(hero, :hp).from(10).to(20)
      end
    end

    context 'when the item_id is a valid key' do
      let(:item_id) { 'dummy' }

      it 'uses up the key in the heroes inventory' do
        expect { use_attempt }.to change(hero.inventory, :length).by(-1)
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:@hero) }
  end
end
