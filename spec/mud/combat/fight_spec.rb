# frozen_string_literal: true

RSpec.describe MUD::Combat::Fight do
  subject(:fight_attempt) { fight_instance.fight(times) }

  let(:fight_instance) { described_class.new(hero, enemy) }
  let(:hero) { MUD::Classes::Fighter.new }
  let(:weapon_name) { MUD::Weapon.new(weapon_id).name }
  let(:weapon_id) { 'knife' }
  let(:enemy) { create(:enemy, enemy_data) }
  let(:enemy_name) { 'Enemy' }
  let(:enemy_data) do
    {
      name: enemy_name,
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

  describe '#fight' do
    context 'when times parameter is 1' do
      let(:times) { 1 }

      it 'calls `fight_once`' do
        expect(fight_instance).to receive(:fight_once).once

        fight_attempt
      end
    end

    context "when times parameter isn't 1" do
      let(:times) { 3 }

      it 'calls `fight_until_death`' do
        expect(fight_instance).to receive(:fight_until_death).once

        fight_attempt
      end
    end
  end

  describe '#fight_once' do
    let(:times) { 1 }
    let(:item_drops_instance) do
      MUD::Combat::ItemDrops.new(hero, enemy)
    end
    let(:attack_instance) do
      MUD::Combat::Attack.new(hero, enemy)
    end
    let(:defend_instance) do
      MUD::Combat::Defend.new(hero, enemy)
    end
    let(:enemy_killed?) { true }

    before do
      switch_logging_to_temp_file
      allow(MUD::Combat::Attack).to receive(:new).and_return(attack_instance)
      allow(attack_instance).to receive(:attack)
      allow(fight_instance).to receive(:enemy_killed?).and_return(enemy_killed?)
      allow(MUD::Combat::Defend).to receive(:new).and_return(defend_instance)
      allow(defend_instance).to receive(:defend)
      allow(MUD::Combat::ItemDrops).to receive(:new).and_return(item_drops_instance)
      allow(item_drops_instance).to receive(:process)
    end

    after do
      fight_attempt
      remove_test_screen_logs
    end

    it 'creates a new `MUD::Combat::Attack` instance' do
      expect(MUD::Combat::Attack).to receive(:new).with(hero, enemy)
    end

    it 'delegates off to the attack instance to deal damage' do
      expect(attack_instance).to receive(:attack)
    end

    it 'checks to see whether the enemy is killed' do
      expect(fight_instance).to receive(:enemy_killed?).once
    end

    context 'when the enemy is killed' do
      it 'outputs that the enemy has been killed' do
        fight_attempt

        expect(log_lines).to include(/You killed the #{enemy_name}/)
      end

      it 'creates a new `MUD::Combat::ItemDrops` instance' do
        expect(MUD::Combat::ItemDrops).to receive(:new).with(hero, enemy)
      end

      it 'delegates off to the item_drops instance to process dropping any items or gold' do
        expect(item_drops_instance).to receive(:process)
      end
    end

    context 'when the enemy is not killed' do
      let(:enemy_killed?) { false }

      it 'creates a new `MUD::Combat::Defend` instance' do
        expect(MUD::Combat::Defend).to receive(:new).with(hero, enemy)
      end

      it 'delegates off to the defend instance to receive damage' do
        expect(defend_instance).to receive(:defend)
      end
    end
  end
end
