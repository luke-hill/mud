# frozen_string_literal: true

RSpec.describe MUD::Enemy do
  subject(:enemy) { create(:enemy, 'bad') }

  let(:dead_enemy) { create(:enemy, 'dead') }

  describe '.of_type' do
    it 'generates an Enemy' do
      expect(described_class.of_type('bad')).to be_a(MUD::Enemy)
    end
  end

  describe '.properties' do
    it 'lists all properties of all types of Enemy' do
      expect(described_class.properties).to be_an(Array)
    end
  end

  describe '#gold' do
    it 'spawns with an amount of gold inside the permitted values' do
      expect(enemy.gold).to be_between(enemy.lower_gold_limit, enemy.upper_gold_limit)
    end
  end

  describe '#hp' do
    it 'spawns with an initial hp inside the permitted values' do
      expect(enemy.hp).to be_between(enemy.lower_hp_limit, enemy.upper_hp_limit)
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

  describe '#potion?' do
    it 'returns true if the enemy is carrying a potion that could be dropped' do
      expect(dead_enemy.potion?).to be true
    end

    it 'returns false if the enemy is not carrying a potion that could be dropped' do
      expect(enemy.potion?).to be false
    end
  end

  describe '#weapon?' do
    it 'returns true if the enemy is carrying a weapon that could be dropped' do
      expect(dead_enemy.weapon?).to be true
    end

    it 'returns false if the enemy is not carrying a weapon that could be dropped' do
      expect(enemy.weapon?).to be false
    end
  end

  describe '#armor?' do
    it 'returns true if the enemy is carrying armor that could be dropped' do
      expect(dead_enemy.armor?).to be true
    end

    it 'returns false if the enemy is not carrying armor that could be dropped' do
      expect(enemy.armor?).to be false
    end
  end

  describe '#speak' do
    it 'can say something if the enemy has a phrase' do
      expect(MUD::Screen).to receive(:output).with("#{'TEST - Equipped DEAD Enemy'.blue}: #{'Hello there ... Yes you!'.green}")

      dead_enemy.speak
    end

    it 'cannot say anything if the enemy has no phrases' do
      expect(MUD::Screen).not_to receive(:output)

      enemy.speak
    end
  end

  describe '#type' do
    let(:boss) { create(:enemy, 'big_boss') }
    let(:unknown_enemy) { create(:enemy, 'not_understood') }

    it 'can classify regular enemies' do
      expect(enemy.type).to eq(:enemy)
    end

    it 'can classify bosses' do
      expect(boss.type).to eq(:boss)
    end

    it 'classifies unknown enemies accordingly' do
      expect(unknown_enemy.type).to eq(:unknown)
    end
  end
end
