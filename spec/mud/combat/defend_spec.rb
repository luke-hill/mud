# frozen_string_literal: true

RSpec.describe MUD::Combat::Defend do
  subject(:defend_instance) { described_class.new(hero, enemy) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:weapon) { MUD::Weapon.of_type('zero') }
  let(:weapon_name) { weapon.name }
  let(:enemy_name) { 'TEST - Bad Enemy' }
  let(:enemy) { create('enemy', 'bad') }

  describe '#defend' do
    subject(:defend_attempt) { defend_instance.defend }

    let(:damage_taken) { 2 }
    let(:missed?) { false }
    let(:missed_message) do
      "The #{enemy_name} swung at you with its #{weapon_name}, but missed.".yellow
    end
    let(:attack_message_regex) do
      /The #{enemy_name} hit you with its #{weapon_name} for #{damage_taken} damage./
    end

    before do
      allow(defend_instance).to receive(:damage_taken).and_return(damage_taken)
      allow(defend_instance).to receive(:missed?).and_return(missed?)
      switch_logging_to_temp_file
    end

    after { remove_test_screen_logs }

    context 'when the enemies attack misses' do
      let(:missed?) { true }

      it 'informs the player that the attack attempt missed' do
        expect(defend_attempt).to eq(missed_message)
      end
    end

    context 'when the weapon deals no damage' do
      let(:damage_taken) { 0 }

      it 'informs the player that the attack attempt missed' do
        expect(defend_attempt).to eq(missed_message)
      end
    end

    it 'informs the player that the attack dealt damage' do
      defend_attempt

      expect(log_lines).to include(attack_message_regex)
    end

    it 'reduces the heroes hp by the amount of damage dealt' do
      expect { defend_attempt }.to change(hero, :hp).by(-2)
    end

    it 'sends a debug statement with the enemies new hp value' do
      defend_attempt

      expect(log_lines).to include(/DEBUG --> YOUR HP:\d+hp./)
    end

    context 'when the attack kills the enemy' do
      let(:damage_taken) { 25 }

      it 'does not send a debug statement with the enemies new hp value' do
        defend_attempt
      rescue StandardError
        expect(log_lines).not_to include(/DEBUG --> YOUR HP:\d+hp./)
      end

      it 'crashes the game as the user died' do
        expect { defend_attempt }.to raise_error(StandardError).with_message('You died!')
      end
    end
  end
end
