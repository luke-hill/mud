# frozen_string_literal: true

RSpec.describe MUD::Actions::Equip do
  subject(:equip_instance) { described_class.new(item_id) }

  let(:player) { MUD::Game.player }
  let(:item_id) { 'knife' }

  before { player.inventory << item_id }

  describe '#equip' do
    context 'when the item_id is not in the inventory' do
      before { player.inventory = [] }

      it 'cannot equip a missing item' do
        expect { equip_instance.equip }
          .to raise_error(ArgumentError)
          .with_message("You do not have a #{item_id} in your inventory.")
      end
    end

    context 'when the item_id is an armor' do
      let(:item_id) { 'zero_shield' }

      it 'can equip an armor' do
        expect { equip_instance.equip }.to change(player, :armor).to(item_id)
      end
    end

    context 'when the item_id is a weapon' do
      let(:item_id) { 'knife' }

      it 'can equip a weapon' do
        expect { equip_instance.equip }.to change(player, :weapon).to(item_id)
      end
    end

    context 'when the item_id is unknown' do
      let(:item_id) { 'unknown' }

      it 'cannot equip an invalid item' do
        expect { equip_instance.equip }
          .to raise_error(ArgumentError)
          .with_message("Cannot classify #{item_id}.")
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:player) }
    it { is_expected.to delegate(:equipment).to(:player) }
  end
end
