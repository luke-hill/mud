# frozen_string_literal: true

RSpec.describe MUD::Combat::Attack do
  subject(:attack_instance) { described_class.new(enemy) }

  let(:player) { MUD::Game.player }
  let(:weapon) { MUD::Weapon.of_type('zero') }
  let(:weapon_name) { weapon.name }
  let(:enemy_name) { 'TEST - Bad Enemy' }
  let(:enemy) { create(:enemy, 'bad') }

  describe '#attack' do
    subject(:attack_attempt) { attack_instance.attack }

    let(:damage_dealt) { 2 }
    let(:missed?) { false }
    let(:missed_message) { "You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow }
    let(:attack_message_regex) do
      /You hit the #{enemy_name} with your #{weapon_name} for #{damage_dealt} damage./
    end

    before do
      allow(player).to receive(:weapon).and_return(weapon)
      allow(attack_instance).to receive(:damage_dealt).and_return(damage_dealt)
      allow(attack_instance).to receive(:missed?).and_return(missed?)
      switch_logging_to_temp_file
    end

    after { remove_test_screen_logs }

    context "when the player's attack misses" do
      let(:missed?) { true }

      it 'informs the player that the attack attempt missed' do
        expect(attack_attempt).to match("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow)
      end
    end

    context 'when the weapon deals no damage' do
      let(:damage_dealt) { 0 }

      it 'informs the player that the attack attempt missed' do
        expect(attack_attempt).to eq(missed_message)
      end
    end

    it 'informs the player that the attack dealt damage' do
      attack_attempt

      expect(log_lines).to include(attack_message_regex)
    end

    it 'reduces the enemies hp by the amount of damage dealt' do
      expect { attack_attempt }.to change(enemy, :hp).by(-2)
    end
  end
end
