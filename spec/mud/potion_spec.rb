# frozen_string_literal: true

RSpec.describe MUD::Potion do
  subject(:potion) { create(:potion, potion_data) }

  let(:potion_data) do
    {
      name: 'Dummy Potion',
      use_message: 'I been used!',
      description: 'A Description',
      value: 3
    }
  end
  let(:player) { MUD::Game.player }

  describe '#use' do
    context 'when the potion is a "healing" potion' do
      before { allow(potion).to receive(:type).and_return(:healing) }

      it 'will recover some hp for the player' do
        expect(player).to receive(:hp=).once

        potion.use
      end
    end

    context 'when the potion is a "mana" potion' do
      before { allow(potion).to receive(:type).and_return(:mana) }

      it 'will recover some mp for the player' do
        expect(player).to receive(:mp=).twice

        potion.use
      end
    end

    context 'when the potion is a "hp bonus" potion' do
      before { allow(potion).to receive(:type).and_return(:hp_bonus) }

      it 'will increase the players `max_hp`' do
        expect(player).to receive(:max_hp=).once

        potion.use
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:name).to(potion) }
    it { is_expected.to delegate(:use_message).to(potion) }
    it { is_expected.to delegate(:description).to(potion) }
    it { is_expected.to delegate(:value).to(potion) }
  end
end
