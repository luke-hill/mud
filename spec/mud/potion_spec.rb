# frozen_string_literal: true

RSpec.describe MUD::Potion do
  let(:player) { MUD::Game.player }
  let(:potion) { create(:potion, 'demo_healing') }
  let(:invalid_potion) { create(:potion, 'does_not_exist') }

  describe '#use' do
    context 'when the potion is a "healing" potion' do
      it 'recovers some hp for the player' do
        expect(player).to receive(:hp=).at_least(:once)

        potion.use
      end

      it 'can output a message that their hp has been fully replenished' do
        allow(player).to receive(:hp).and_return(player.max_hp)

        expect(MUD::Screen).to receive(:output).with(/You feel yourself regain full strength/)

        potion.use
      end
    end

    context 'when the potion is a "mana" potion' do
      let(:potion) { create(:potion, 'demo_mana') }

      it 'recovers some mp for the player' do
        expect(player).to receive(:mp=).at_least(:once)

        potion.use
      end

      it 'can output a message that their mp has been fully replenished' do
        allow(player).to receive(:mp).and_return(player.max_mp)

        expect(MUD::Screen).to receive(:output).with(/You feel yourself regain full magic power/)

        potion.use
      end
    end

    context 'when the potion is a "hp bonus" potion' do
      let(:potion) { create(:potion, 'demo_endurance') }

      it 'increases the players maximum hp' do
        expect(player).to receive(:max_hp=).once

        potion.use
      end
    end

    context 'when the potion has no use_message property' do
      let(:potion) { create(:potion, 'missing_message') }

      it 'outputs a generic use message' do
        expect(MUD::Screen).to receive(:output).with('ERROR: Unknown Potion - Will use up and continue.')

        potion.use
      end
    end

    context 'when invalid' do
      it 'crashes when used' do
        expect { invalid_potion.use }.to raise_error.with_message('Potion not found with ID: does_not_exist')
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

  it 'crashes when accessing any potion method' do
    expect { invalid_potion.name }.to raise_error.with_message('Potion not found with ID: does_not_exist')
  end
end
