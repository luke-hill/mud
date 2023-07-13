# frozen_string_literal: true

RSpec.describe MUD::Combat::ItemDrops do
  let(:item_drops_instance) { described_class.new(hero, enemy) }
  let(:hero) { MUD::Classes::Fighter.new }
  let(:enemy) { create(:enemy, 'dead') }

  describe '#process' do
    subject(:drop_items) { item_drops_instance.process }

    before { switch_logging_to_temp_file }

    after { remove_test_screen_logs }

    context 'when dropping a potion' do
      let(:dropped_potion_chance) { 1 }

      it 'places the potion in the inventory of the hero' do
        drop_items

        expect(hero.inventory).to include('lesser_healing_potion')
      end

      it 'informs the user that the potion dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_potion_message}/)
      end
    end

    context 'when dropping a weapon' do
      it 'places the weapon in the inventory of the hero' do
        drop_items

        expect(hero.inventory).to include('goblin_axe')
      end

      it 'informs the user that the weapon dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_weapon_message}/)
      end
    end

    context 'when dropping an armor' do
      it 'places the armor in the inventory of the hero' do
        drop_items

        expect(hero.inventory).to include('bandit_leathers')
      end

      it 'informs the user that the armor dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_armor_message}/)
      end
    end

    context 'when dropping gold' do
      it 'increases the heroes gold by the amount dropped' do
        expect { drop_items }.to change(hero, :gold).by(5)
      end

      it 'informs the user that the gold dropped' do
        drop_items

        expect(log_lines).to include(/You found .*\d+ gold coins?.* on the corpse of the .*/)
      end
    end
  end
end
