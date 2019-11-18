# frozen_string_literal: true

RSpec.describe MUD::Actions::Command do
  let(:command) { described_class.new(command_input) }
  let(:player) { MUD::Game.player }

  before { switch_logging_to_temp_file }

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
        command.process

        expect(log_lines.length).to be > 20
      end
    end

    context 'when command input is "quit"' do
      let(:command_input) { 'quit' }

      before do
        allow(command).to receive(:sleep)
        allow(command).to receive(:exit)
      end

      it 'kills the player and quits the game' do
        expect(command).to receive(:exit)

        command.process
      end
    end

    context 'when command input is "north"' do
      let(:command_input) { 'north' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "n"' do
      let(:command_input) { 'n' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "south"' do
      let(:command_input) { 'south' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "s"' do
      let(:command_input) { 's' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "east"' do
      let(:command_input) { 'east' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "e"' do
      let(:command_input) { 'e' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "west"' do
      let(:command_input) { 'west' }

      include_examples 'Command movement examples'
    end

    context 'when command input is "w"' do
      let(:command_input) { 'w' }

      include_examples 'Command movement examples'
    end
  end
end
