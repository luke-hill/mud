# frozen_string_literal: true

RSpec.describe MUD::Helpers::Item do
  let(:item_helper) { klass.new }

  let(:klass) do
    Class.new do
      include MUD::Helpers::Item
    end
  end

  let(:weapon_list) do
    {
      'weapon_one' => {
        'name' => 'Weapon One',
        'description' => 'This weapon is first',
        'min_power' => 0,
        'max_power' => 1
      },
      'weapon_two' => {
        'name' => 'Weapon Two',
        'description' => 'This weapon is second',
        'min_power' => 2,
        'max_power' => 3
      }
    }
  end

  let(:armor_list) do
    {
      'armor_one' => {
        'name' => 'Armor One',
        'description' => 'This armor is first',
        'defense' => 0
      },
      'armor_two' => {
        'name' => 'Armor Two',
        'description' => 'This armor is second',
        'defense' => 2
      }
    }
  end

  describe '#weapon_ids' do
    before do
      allow(item_helper).to receive(:weapon_yml).and_return(weapon_list)
    end

    it 'outputs a list of the ids of all weapons that exist' do
      expect(item_helper.weapon_ids).to eq(%w[weapon_one weapon_two])
    end
  end

  describe '#armor_ids' do
    before do
      allow(item_helper).to receive(:armor_yml).and_return(armor_list)
    end

    it 'outputs a list of the ids of all armors that exist' do
      expect(item_helper.armor_ids).to eq(%w[armor_one armor_two])
    end
  end

  describe '#gold_description' do
    it 'outputs the description of gold' do
      expect(item_helper.gold_description)
        .to eq('Glistening in your hand, these gold coins are trade-able at just about any shop.')
    end
  end
end
