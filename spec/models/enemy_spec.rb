require 'rails_helper'

RSpec.describe Enemy, type: :model do
  let(:enemy) { create(:enemy) }
  let(:dead_enemy) { create(:enemy, :dead) }

  describe 'validations' do
    context 'a valid enemy' do
      it 'has a name' do
        expect(enemy.name.length).to be > 3
      end

      it 'has a description' do
        expect(enemy.description.length).to be > 15
      end

      it 'has a weapon and armor' do
        expect(enemy.weapon_id).not_to be_nil

        expect(enemy.armor_id).not_to be_nil
      end

      it 'has a lower and upper hp limit' do
        skip 'Get some tips on if this is the best way to do this'
        expect(enemy.lower_hp_limit).to be < enemy.upper_hp_limit
      end

      it "doesn't hit you all the time" do
        expect(enemy.accuracy).to be < 1
      end

      it 'has a lower and upper gold limit' do
        skip 'Get some tips on if this is the best way to do this'
        expect(enemy.lower_gold_limit).to be < enemy.upper_gold_limit
      end

      it 'has an xp value' do
        expect(enemy.xp).not_to be_nil
      end

      it 'has an xp_killshot value' do
        expect(enemy.xp_killshot).not_to be_nil
      end

      it 'has stamina' do
        expect(enemy.stamina).to be_between(1, 2)
      end

      it 'saves to the database' do
        expect { enemy }.to change { Enemy.count }.by(1)
      end
    end

    context 'an invalid enemy' do
      let(:enemy) { Enemy.create }
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

  describe 'hp' do
    it '#hp returns the enemies hp' do
      _enemy = enemy

      expect(_enemy.hp).to be_between(_enemy.lower_hp_limit, _enemy.upper_hp_limit)
    end

    it '#hp= updates the enemies hp' do
      _enemy = enemy
      initial_hp = _enemy.hp

      _enemy.hp -= 1
      updated_hp = _enemy.hp

      expect(initial_hp).not_to eq(updated_hp)
    end
  end

  describe 'gold' do
    it '#gold returns the enemies gold' do
      _enemy = enemy

      expect(_enemy.gold).to be_between(_enemy.lower_gold_limit, _enemy.upper_gold_limit)
    end

    it '#gold= updates the enemies gold' do
      _enemy = enemy
      initial_gold = _enemy.gold

      _enemy.gold -= 1
      updated_gold = _enemy.gold

      expect(initial_gold).not_to eq(updated_gold)
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
    it 'alters an enemies hp to 0 if it was negative' do
      _enemy = dead_enemy
      _enemy.hp
      _enemy.hp -= 1
      initial_hp = _enemy.hp

      _enemy.prevent_negative_hp
      updated_hp = _enemy.hp

      expect(initial_hp).not_to eq(updated_hp)
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
