# frozen_string_literal: true

RSpec.describe MUD::Potion do
  let(:player) { MUD::Game.player }

  describe '#use' do
    context 'when the potion is a "healing" potion' do
      let(:potion) { create_potion('healing') }

      it 'will recover some hp for the player' do
        expect(player).to receive(:hp=).once

        potion.use
      end
    end

    context 'when the potion is a "mana" potion' do
      let(:potion) { create_potion('mana') }

      it 'will recover some mp for the player' do
        expect(player).to receive(:mp=).once

        potion.use
      end
    end

    context 'when the potion is a "hp bonus" potion' do
      let(:potion) { create_potion('hp_bonus') }

      it 'will increase the players `max_hp`' do
        expect(player).to receive(:max_hp=).once

        potion.use
      end
    end
  end
end
