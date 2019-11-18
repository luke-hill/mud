# frozen_string_literal: true

RSpec.describe MUD::Actions::Equip do
  subject(:equip_instance) { described_class.new(hero, item_id) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:item_id) { 'vest' }

  before do
    hero.inventory << item_id
  end

  describe '#equip' do
    context 'when the item_id is an armor' do
      let(:item_id) { 'vest' }

      it 'can equip an armor' do
        expect { equip_instance.equip }.to change(hero, :armor).to(item_id)
      end
    end

    context 'when the item_id is an armor' do
      let(:item_id) { 'knife' }

      it 'can equip a weapon' do
        expect { equip_instance.equip }.to change(hero, :weapon).to(item_id)
      end
    end

    context 'when the item_id is unknown' do
      let(:item_id) { 'unknown' }

      it 'cannot equip an invalid item' do
        expect { equip_instance.equip }
          .to raise_error(RuntimeError)
          .with_message("Cannot classify #{item_id}.")
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:@hero) }
    it { is_expected.to delegate(:equipment).to(:@hero) }
  end
end
