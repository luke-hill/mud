# frozen_string_literal: true

RSpec.describe MUD::Combat::Fight do
  subject(:fight_attempt) { fight_instance.fight(times) }

  let(:fight_instance) { described_class.new(hero, enemy) }
  let(:hero) { MUD::Classes::Fighter.new }
  let(:enemy) { create(:enemy, 'bad') }

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
    let(:item_drops_instance) { MUD::Combat::ItemDrops.new(enemy) }
    let(:attack_instance) { MUD::Combat::Attack.new(enemy) }
    let(:defend_instance) { MUD::Combat::Defend.new(enemy) }
    let(:damage_dealt) { 100 }

    before do
      switch_logging_to_temp_file
      allow(MUD::Combat::Attack).to receive(:new).and_return(attack_instance)
      allow(attack_instance).to receive(:attack)
      allow(attack_instance).to receive(:damage_dealt).and_return(damage_dealt)
    end

    after do
      remove_test_screen_logs
    end

    it 'delegates off to the `MUD::Combat::Attack` instance to deal damage' do
      expect(attack_instance).to receive(:attack)

      fight_attempt
    end

    it 'checks to see whether the enemy is dead' do
      expect(fight_instance).to receive(:enemy_dead?).at_least(:twice)

      fight_attempt
    end

    context 'when the enemy is killed' do
      before do
        allow(fight_instance).to receive(:enemy_dead?).and_return(false, true)
        allow(MUD::Combat::ItemDrops).to receive(:new).and_return(item_drops_instance)
        allow(item_drops_instance).to receive(:process)
      end

      it 'outputs that the enemy has been killed' do
        fight_attempt

        expect(log_lines).to include(/You killed the \w+/)
      end

      it 'creates a new `MUD::Combat::ItemDrops` instance' do
        expect(MUD::Combat::ItemDrops).to receive(:new).with(enemy)

        fight_attempt
      end

      it 'delegates off to the item_drops instance to process dropping any items or gold' do
        expect(item_drops_instance).to receive(:process)

        fight_attempt
      end
    end

    context 'when the enemy is not killed' do
      before do
        allow(fight_instance).to receive(:enemy_dead?).and_return(false)
        allow(MUD::Combat::Defend).to receive(:new).and_return(defend_instance)
        allow(defend_instance).to receive(:defend)
      end

      it 'delegates off to the `MUD::Enemy` to see if it will speak' do
        expect(enemy).to receive(:speak).once

        fight_attempt
      end

      it 'delegates off to the `MUD::Combat::Defend` instance to receive damage' do
        expect(defend_instance).to receive(:defend)

        fight_attempt
      end
    end
  end
end
