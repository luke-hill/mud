# frozen_string_literal: true

RSpec.describe MUD::Combat::ItemDrops do
  let(:item_drops_instance) { described_class.new(enemy) }
  let(:player) { MUD::Game.player }
  let(:enemy) { create(:enemy, 'dead') }

  before do
    player.inventory = []
    allow(player).to receive(:max_inventory_size).and_return(10)
  end

  describe '#process' do
    subject(:drop_items) { item_drops_instance.process }

    context 'when dropping a potion' do
      it 'places the potion in the inventory of the player' do
        drop_items

        expect(player.inventory).to include('lesser_healing_potion')
      end

      it 'informs the user that the potion dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_potion_message}/)
      end
    end

    context 'when dropping a weapon' do
      it 'places the weapon in the inventory of the player' do
        drop_items

        expect(player.inventory).to include('goblin_axe')
      end

      it 'informs the user that the weapon dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_weapon_message}/)
      end
    end

    context 'when dropping an armor' do
      it 'places the armor in the inventory of the player' do
        drop_items

        expect(player.inventory).to include('bandit_leathers')
      end

      it 'informs the user that the armor dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_armor_message}/)
      end
    end

    context 'when dropping gold' do
      it 'increases the players gold by the amount dropped' do
        expect { drop_items }.to change(player, :gold).by(5)
      end

      it 'informs the user that the gold dropped' do
        drop_items

        expect(log_lines).to include(/You found .*\d+ gold coins?.* on the corpse of the .*/)
      end
    end
  end
end
