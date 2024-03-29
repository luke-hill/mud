# frozen_string_literal: true

RSpec.describe MUD::Combat::Defend do
  subject(:defend_attempt) { defend_instance.defend }

  let(:defend_instance) { described_class.new(enemy) }
  let(:enemy) { create(:enemy, 'bad') }
  let(:player) { MUD::Game.player }
  let(:weapon_name) { MUD::Weapon.of_type(enemy.weapon_id).name }

  before { player.hp = player.max_hp }

  describe '#defend' do
    context 'when the enemies attack misses' do
      before { allow(defend_instance).to receive(:missed?).and_return(true) }

      it 'informs the player that the enemy attack attempt missed' do
        expect(defend_instance).to receive(:missed_message)

        defend_attempt
      end
    end

    context 'when the player takes no damage' do
      before { allow(defend_instance).to receive_messages(defense_value: 3, missed?: false) }

      it 'informs the player that the enemy attack attempt missed' do
        expect(defend_instance).to receive(:missed_message)

        defend_attempt
      end
    end

    context 'when the player takes some damage' do
      before { allow(defend_instance).to receive_messages(attack_value: 2, defense_value: 0, missed?: false) }

      it 'informs the player that the attack dealt damage' do
        defend_attempt

        expect(log_lines).to include(/The #{enemy.name} hit you with its #{weapon_name} for 2 damage./)
      end

      it 'reduces the players hp by the amount of damage dealt' do
        expect { defend_attempt }.to change(MUD::Game.player, :hp).by(-2)
      end

      it 'sends a debug statement with the players new hp value' do
        defend_attempt

        expect(log_lines).to include(/DEBUG --> YOUR HP:\d+hp./)
      end
    end

    context 'when the attack kills the player' do
      before { allow(defend_instance).to receive_messages(damage_taken:, missed?: false) }

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
