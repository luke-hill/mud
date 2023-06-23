# frozen_string_literal: true

RSpec.describe MUD::Combat::ItemDrops do
  subject(:item_drops_instance) { described_class.new(hero, enemy) }

  before do
    allow(enemy).to receive(:enemy_data).and_return(enemy_data)
  end

  let(:hero) { MUD::Classes::Fighter.new }
  let(:enemy) { create(:enemy, enemy_data) }
  let(:enemy_data) do
    { name: 'Enemy' }.merge(potion_drop_data).merge(weapon_drop_data).merge(armor_drop_data)
  end
  let(:potion_drop_data) do
    {
      dropped_potion_id: 'lesser_healing_potion',
      dropped_potion_message: 'Drop potion message'
    }
  end
  let(:weapon_drop_data) do
    {
      dropped_weapon_id: 'goblin_axe',
      dropped_weapon_message: 'I drop a weapon!!'
    }
  end
  let(:armor_drop_data) do
    {
      dropped_armor_id: 'orc_shield',
      dropped_armor_message: 'This be a shield!'
    }
  end

  describe '#process' do
    subject(:drop_items) { item_drops_instance.process }

    let(:dropped_potion_chance) { 0 }
    let(:dropped_weapon_chance) { 0 }
    let(:dropped_armor_chance)  { 0 }
    let(:dropped_gold)          { 0 }

    before do
      allow(enemy).to receive(:dropped_potion_chance).and_return(dropped_potion_chance)
      allow(enemy).to receive(:dropped_weapon_chance).and_return(dropped_weapon_chance)
      allow(enemy).to receive(:dropped_armor_chance).and_return(dropped_armor_chance)
      allow(enemy).to receive(:gold).and_return(dropped_gold)
      switch_logging_to_temp_file
    end

    after { remove_test_screen_logs }

    context 'when dropping a potion' do
      let(:dropped_potion_chance) { 1 }

      it 'drops a potion to the floor of the current room' do
        drop_items

        expect(hero.current_room.floor).to include(potion_drop_data[:dropped_potion_id])
      end

      it 'informs the user that the potion dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_potion_message}/)
      end
    end

    context 'when dropping a weapon' do
      let(:dropped_weapon_chance) { 1 }

      it 'drops a weapon to the floor of the current room' do
        drop_items

        expect(hero.current_room.floor).to include(weapon_drop_data[:dropped_weapon_id])
      end

      it 'informs the user that the weapon dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_weapon_message}/)
      end
    end

    context 'when dropping an armor' do
      let(:dropped_armor_chance) { 1 }

      it 'drops an armor to the floor of the current room' do
        drop_items

        expect(hero.current_room.floor).to include(armor_drop_data[:dropped_armor_id])
      end

      it 'informs the user that the armor dropped' do
        drop_items

        expect(log_lines).to include(/#{enemy.dropped_armor_message}/)
      end
    end

    context 'when dropping gold' do
      let(:dropped_gold) { 1 }

      it 'increases the heroes gold by the amount dropped' do
        expect { drop_items }.to change(hero, :gold).by(1)
      end

      it 'informs the user that the weapon dropped' do
        drop_items

        expect(log_lines).to include(/You found 1 gold coin on the corpse of the Enemy/)
      end
    end
  end
end
