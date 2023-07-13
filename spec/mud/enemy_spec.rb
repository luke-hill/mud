# frozen_string_literal: true

RSpec.describe MUD::Enemy do
  subject(:enemy) { create_bad_enemy }

  let(:dead_enemy) { create_dead_enemy }

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

  describe '#alive?' do
    it 'returns true if the enemy is alive' do
      expect(enemy.alive?).to be true
    end

    it 'returns false if the enemy is dead' do
      expect(dead_enemy.alive?).to be false
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

  describe '#prevent_negative_hp' do
    context 'with an enemy with negative hp' do
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
