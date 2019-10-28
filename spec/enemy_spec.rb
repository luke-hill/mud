RSpec.describe MUD::Enemy do
  let(:enemy) { create(enemy_data) }
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
