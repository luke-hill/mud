# frozen_string_literal: true

RSpec.describe MUD::Combat::XP do
  subject(:xp_attempt) { xp_instance.increase }

  let(:xp_instance) { described_class.new(enemy, damage_dealt) }
  let(:enemy) { create(:enemy, 'bad') }
  let(:player) { MUD::Game.player }
  let(:damage_dealt) { 10 }

  before { allow(player).to receive(:capped?).and_return(capped?) }

  describe '#increase' do
    context 'when player is already capped' do
      let(:capped?) { true }

      it 'does not increase the players xp' do
        expect { xp_attempt }.not_to change(player, :experience)
      end

      it 'informs the player they are capped' do
        expect(MUD::Screen).to receive(:output).with('You feel strong enough to reach the next level. Seek out a Guild.'.yellow.blink)

        xp_attempt
      end
    end

    context 'when player is not capped' do
      let(:capped?) { false }

      it 'increases the players xp' do
        expect { xp_attempt }.to change(player, :experience)
      end

      it 'yields a killshot bonus if the enemy dies' do
        allow(xp_instance).to receive(:killshot?).and_return(true)

        expect(enemy).to receive(:xp_killshot).at_least(:once).and_call_original

        xp_attempt
      end

      it 'does not yield a killshot bonus if the enemy does not die' do
        allow(xp_instance).to receive(:killshot?).and_return(false)

        expect(enemy).not_to receive(:xp_killshot)

        xp_attempt
      end
    end
  end
end
