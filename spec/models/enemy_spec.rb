require 'rails_helper'

RSpec.describe Enemy, type: :model do
  let(:enemies) { create(:enemies) }
  let(:dead_enemy) { create(:enemies, :dead) }

  describe 'validations' do
    context 'a valid enemy' do
      it { should validate_presence_of(:name) }

      it { should validate_presence_of(:description) }

      it { should validate_presence_of(:weapon_id) }

      it { should validate_presence_of(:armor_id) }

      it 'has a lower and upper hp limit' do
        expect(enemy).to validate_numericality_of(:upper_hp_limit)
          .is_greater_than_or_equal_to(enemy.lower_hp_limit)
      end

      it 'has a lower and upper gold limit' do
        expect(enemy).to validate_numericality_of(:upper_gold_limit)
          .is_greater_than_or_equal_to(enemy.lower_gold_limit)
      end

      it { should validate_presence_of(:xp) }

      it { should validate_presence_of(:xp_killshot) }

      it { should validate_inclusion_of(:stamina).in_range(0..2) }

      it { should validate_numericality_of(:accuracy).is_less_than(1) }

      it 'saves to the database' do
        expect { enemy }.to change { Enemy.count }.by(1)
      end
    end

    context 'an invalid enemy' do
      let(:enemies) { Enemy.create }
      let(:errors) { enemy.errors }

      it 'has no name' do
        expect(errors).to have_key(:name)
      end

      it 'has no description' do
        expect(errors).to have_key(:description)
      end

      it 'has no weapon or armor' do
        expect(errors).to have_key(:weapon_id)

        expect(errors).to have_key(:armor_id)
      end

      it 'has no lower or upper hp limit' do
        expect(errors).to have_key(:lower_hp_limit)

        expect(errors).to have_key(:upper_hp_limit)
      end

      it 'has no accuracy value' do
        expect(errors).to have_key(:accuracy)
      end

      it 'has no lower or upper gold limit' do
        expect(errors).to have_key(:lower_gold_limit)

        expect(errors).to have_key(:upper_gold_limit)
      end

      it 'has no xp value' do
        expect(errors).to have_key(:xp)
      end

      it 'has no xp_killshot value' do
        expect(errors).to have_key(:xp_killshot)
      end

      it 'has no stamina value' do
        expect(errors).to have_key(:stamina)
      end

      it 'does not save to the database' do
        expect { enemy }.not_to change { Enemy.count }
      end
    end
  end

  describe 'Hit Points' do
    context '#hp' do
      it 'spawns with an initial hp inside the permitted values' do
        _enemy = enemy

        expect(_enemy.hp).to be_between(_enemy.lower_hp_limit, _enemy.upper_hp_limit)
      end
    end

    context '#hp=' do
      it 'Updates the enemies hit points' do
        _enemy = enemy
        initial_hp = _enemy.hp

        _enemy.hp -= 1
        updated_hp = _enemy.hp

        expect(initial_hp).not_to eq(updated_hp)
      end
    end
  end

  describe 'Gold' do
    context '#gold' do
      it 'spawns with an amount of gold inside the permitted values' do
        _enemy = enemy

        expect(_enemy.gold).to be_between(_enemy.lower_gold_limit, _enemy.upper_gold_limit)
      end
    end

    context '#gold=' do
      it 'Updates the enemies gold' do
        _enemy = enemy
        initial_gold = _enemy.gold

        _enemy.gold -= 1
        updated_gold = _enemy.gold

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

  describe '#prevent_negative_hp' do
    context 'an enemy with negative hp' do
      it 'alters an enemies hp to 0 if it was negative' do
        _enemy = dead_enemy
        _enemy.hp
        _enemy.hp -= 1
        initial_hp = _enemy.hp

        _enemy.prevent_negative_hp
        updated_hp = _enemy.hp

        expect(initial_hp).not_to eq(updated_hp)
      end
    end

    it 'has no affect if the enemy is alive' do
      _enemy = enemy
      initial_hp = _enemy.hp

      _enemy.prevent_negative_hp
      updated_hp = _enemy.hp

      expect(initial_hp).to eq(updated_hp)
    end

    it 'has no affect if the enemy has 0 hp' do
      _enemy = dead_enemy
      initial_hp = _enemy.hp

      _enemy.prevent_negative_hp
      updated_hp = _enemy.hp

      expect(initial_hp).to eq(updated_hp)
    end
  end
end
