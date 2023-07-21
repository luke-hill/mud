# frozen_string_literal: true

RSpec.describe MUD::Key do
  let(:player) { MUD::Game.player }

  describe '#use' do
    context 'when the key has a defined `use_message`' do
      let(:key) { create(:key, 'dummy') }

      it 'will output the keys use_message property' do
        expect(MUD::Screen).to receive(:output).with('I g0t used'.yellow)

        key.use
      end
    end

    context 'when the key does not have a defined `use_message`' do
      let(:key) { create(:key, 'half_configured') }

      it 'will output a standard fallback message' do
        expect(MUD::Screen).to receive(:output).with('ERROR: Unknown Key - Will use up and continue.'.yellow)

        key.use
      end
    end
  end
end
