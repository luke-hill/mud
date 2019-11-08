# frozen_string_literal: true

RSpec.describe MUD::Actions::Command do
  subject(:command) { described_class.new(command_input) }

  let(:player) { MUD::Game.player }

  describe '#process' do
    context 'when command input is an empty string' do
      let(:command_input) { '' }

      it 'looks around' do
        expect(player).to receive(:look_around)

        command.process
      end
    end

    context 'when command input is "debug"' do
      let(:command_input) { 'debug' }

      it 'returns a debug dump of all the diagnostic info on the game' do
        expect(command).to receive(:output_diagnostic_info)

        command.process
      end
    end

    context 'when command input is "quit"' do
      let(:command_input) { 'quit' }

      it 'kills the player and quits the game' do
        expect(command).to receive(:die)

        command.process
      end
    end

    context 'when command input is "north"' do
      let(:command_input) { 'north' }

      include_examples 'Command movement examples'
    end

    # %w[n north s south w west e east u up d down].include?(command_input)
  end
end
