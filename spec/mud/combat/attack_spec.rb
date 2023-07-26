# frozen_string_literal: true

RSpec.describe MUD::Combat::Attack do
  subject(:attack_attempt) { attack_instance.attack }

  let(:attack_instance) { described_class.new(enemy) }
  let(:attack_message_regex) { /You hit the #{enemy_name} with your #{weapon_name} for \d+ damage./ }
  let(:enemy) { create(:enemy, 'bad') }
  let(:enemy_name) { 'TEST - Bad Enemy' }
  let(:weapon) { MUD::Weapon.of_type('zero') }
  let(:weapon_name) { weapon.name }

  before do
    allow(MUD::Game.player).to receive(:weapon).and_return(weapon)
    allow(attack_instance).to receive(:missed?).and_return(false)
    switch_logging_to_temp_file
  end

  after { remove_test_screen_logs }

  describe '#attack' do
    context "when the player's attack misses" do
      before { allow(attack_instance).to receive(:missed?).and_return(true) }

      it 'informs the player that the attack attempt missed' do
        expect(attack_instance).to receive(:missed_message)

        attack_attempt
      end
    end

    context 'when the weapon deals no damage' do
      before do
        allow(attack_instance).to receive(:damage_dealt).and_return(0)
      end

      it 'informs the player that the attack attempt missed' do
        expect(attack_instance).to receive(:missed_message)

        attack_attempt
      end
    end

    context 'when the weapon would have dealt negative damage' do
      before do
        allow(attack_instance).to receive(:defense_value).and_return(1000)
      end

      it 'informs the player that the attack attempt missed' do
        expect(attack_attempt).to eq("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow)
      end

      it 'does not alter the enemies hp' do
        expect { attack_attempt }.not_to change(enemy, :hp)
      end
    end

    it 'informs the player that the attack dealt damage' do
      attack_attempt

      expect(log_lines).to include(attack_message_regex)
    end

    it 'reduces the enemies hp by the amount of damage dealt' do
      expect { attack_attempt }.to change(enemy, :hp)
    end
  end
end
