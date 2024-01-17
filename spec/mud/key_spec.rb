# frozen_string_literal: true

RSpec.describe MUD::Key do
  let(:player) { MUD::Game.player }
  let(:key) { create(:key, 'dummy') }

  describe '#use' do
    context 'when the key has a defined message to be shown when used' do
      it 'outputs the keys `use_message` property' do
        expect(MUD::Screen).to receive(:output).with('I g0t used'.yellow)

        key.use
      end
    end

    context 'when the key does not have a defined message to be shown when used' do
      let(:key) { create(:key, 'half_configured') }

      it 'outputs a standard fallback message' do
        expect(MUD::Screen).to receive(:output).with('ERROR: Unknown Key - Will use up and continue.'.yellow)

        key.use
      end
    end
  end

  it 'has a name' do
    expect(key.name).to eq('Dummy Key')
  end

  it 'has a use_message' do
    expect(key.use_message).to eq('I g0t used')
  end

  it 'has a description' do
    expect(key.description).to eq('A description')
  end

  it 'has a missing_message' do
    expect(key.missing_message).to eq('Oh dear, no key!')
  end
end
