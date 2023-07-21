# frozen_string_literal: true

RSpec.describe MUD::Actions::Command do
  let(:command) { described_class.new(command_input) }
  let(:player) { MUD::Game.player }

  before do
    switch_logging_to_temp_file
    player.current_room = MUD::Room.new('blank_room')
  end

  after { remove_test_screen_logs }

  describe '#process' do
    context 'when command input is "a"' do
      let(:command_input) { 'a' }

      it 'fights the enemy' do
        expect(player).to receive(:fight)

        command.process
      end
    end

    context 'when command input is "attack"' do
      let(:command_input) { 'attack' }

      it 'fights the enemy' do
        expect(player).to receive(:fight)

        command.process
      end
    end

    context 'when command input is an empty string' do
      let(:command_input) { '' }

      it 'looks around' do
        expect(player).to receive(:look_around)

        command.process
      end
    end

    context 'when command input is "debug"' do
      let(:command_input) { 'debug' }

      before do
        allow(player).to receive(:weapon).and_return(MUD::Weapon.of_type('zero'))
        allow(player).to receive(:armor).and_return(MUD::Armor.of_type('zero_shield'))
      end

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

    context 'when command input is an unknown command' do
      let(:command_input) { 'fooBARBaz' }

      it 'informs the user the command is invalid' do
        expect(MUD::Screen).to receive(:output).with('Input not yet recognised as a valid command'.red.blink)

        command.process
      end
    end
  end
end
