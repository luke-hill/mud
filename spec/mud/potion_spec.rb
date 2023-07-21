# frozen_string_literal: true

RSpec.describe MUD::Potion do
  let(:player) { MUD::Game.player }
  let(:potion) { create(:potion, 'demo_healing') }

  describe '#use' do
    context 'when the potion is a "healing" potion' do
      it 'will recover some hp for the player' do
        expect(player).to receive(:hp=).once

        potion.use
      end
    end

    context 'when the potion is a "mana" potion' do
      let(:potion) { create(:potion, 'demo_mana') }

      it 'will recover some mp for the player' do
        expect(player).to receive(:mp=).once

        potion.use
      end
    end

    context 'when the potion is a "hp bonus" potion' do
      let(:potion) { create(:potion, 'demo_endurance') }

      it 'will increase the players `max_hp`' do
        expect(player).to receive(:max_hp=).once

        potion.use
      end
    end
  end

  it 'has a name' do
    expect(potion.name).to eq('Demo Healing Potion')
  end

  it 'has a use_message' do
    expect(potion.use_message).to eq('This is a demo consumption')
  end

  it 'has a description' do
    expect(potion.description).to eq('Demo Healing Potion Description')
  end

  it 'has a value' do
    expect(potion.value).to eq(10)
  end
end
