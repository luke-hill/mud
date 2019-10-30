# frozen_string_literal: true

RSpec.describe MUD::Enemy do
  let(:enemy) { create(:enemy, enemy_data) }
  let(:dead_enemy) do
    enemy.tap { |enemy| enemy.hp = 0 }
  end
  let(:enemy_data) do
    {
      name: 'Enemy',
      description: 'A Description',
      weapon_id: 'fists',
      armor_id: 'unarmored',
      lower_hp_limit: 5,
      upper_hp_limit: 13,
      accuracy: 0.7,
      lower_gold_limit: 0,
      upper_gold_limit: 3,
      xp: 2,
      xp_killshot: 10,
      stamina: 1
    }
  end

  describe 'delegated methods' do
    data_keys = %i(
      name
      description
      weapon_id
      armor_id
      lower_hp_limit
      upper_hp_limit
      accuracy
      lower_gold_limit
      upper_gold_limit
      xp
      xp_killshot
      stamina
    )
    data_keys.each do |key|
      it "delegates calling #{key} on the Enemy class to the enemy data" do
        expect { enemy.send(key) }.not_to raise_error
      end
    end
  end

  describe 'Hit Points' do
    describe '#hp' do
      it 'spawns with an initial hp inside the permitted values' do
        expect(enemy.hp).to be_between(enemy.lower_hp_limit, enemy.upper_hp_limit)
      end
    end

    describe '#hp=' do
      it 'Updates the enemies hit points' do
        initial_hp = enemy.hp
        enemy.hp -= 1
        updated_hp = enemy.hp

        expect(initial_hp).not_to eq(updated_hp)
      end
    end
  end

  describe 'Gold' do
    describe '#gold' do
      it 'spawns with an amount of gold inside the permitted values' do
        expect(enemy.gold).to be_between(enemy.lower_gold_limit, enemy.upper_gold_limit)
      end
    end

    describe '#gold=' do
      it 'Updates the enemies gold' do
        initial_gold = enemy.gold
        enemy.gold -= 1
        updated_gold = enemy.gold

        expect(initial_gold).not_to eq(updated_gold)
      end
    end
  end

  describe '#dead?' do
    it 'returns true if the enemy is dead' do
      expect(dead_enemy.dead?).to be true
    end

    it 'returns false if the enemy is alive' do
      expect(enemy.dead?).to be false
    end
  end

  describe '#alive?' do
    it 'returns true if the enemy is alive' do
      expect(enemy.alive?).to be true
    end

    it 'returns false if the enemy is dead' do
      expect(dead_enemy.alive?).to be false
    end
  end

  describe '#prevent_negative_hp' do
    context 'an enemy with negative hp' do
      it 'alters an enemies hp to 0 if it was negative' do
        dead_enemy.hp -= 1
        initial_hp = dead_enemy.hp
        dead_enemy.prevent_negative_hp
        updated_hp = dead_enemy.hp

        expect(initial_hp).not_to eq(updated_hp)
      end
    end

    it 'has no affect if the enemy is alive' do
      initial_hp = enemy.hp
      enemy.prevent_negative_hp
      updated_hp = enemy.hp

      expect(initial_hp).to eq(updated_hp)
    end

    it 'has no affect if the enemy has 0 hp' do
      initial_hp = dead_enemy.hp
      dead_enemy.prevent_negative_hp
      updated_hp = dead_enemy.hp

      expect(initial_hp).to eq(updated_hp)
    end
  end

  describe '#defense' do
    it 'returns the integer value of the defense value of the equipped armor' do
      expect(enemy.defense).to eq(0)
    end
  end
end
