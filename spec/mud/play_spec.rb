# frozen_string_literal: true

RSpec.describe MUD::Play do
  subject(:play_game) { described_class.play }

  let(:player) { MUD::Game.player }
  let(:user_input) { 'some_command' }
  let(:command_instance) { MUD::Actions::Command.new(user_input) }

  before do
    allow($stdin).to receive(:gets).and_return(user_input)
    allow(MUD::Game).to receive(:setup)
    allow(MUD::Game).to receive(:display_welcome_message)
    allow(MUD::Actions::Command).to receive(:new).with(user_input).and_return(command_instance)
  end

  after { ENV['DATA_SOURCE'] = 'spec/support/fixtures' }

  describe '#play' do
    context 'when alive' do
      before do
        # This alive->dead switch is so the spec runner doesn't hit an infinite loop
        allow(player).to receive(:alive?).and_return(true, false)
        allow(Kernel).to receive(:exit)
      end

      it 'delegates input commands to the `MUD::Actions::Command` class' do
        expect(command_instance).to receive(:process).at_least(:once)

        play_game
      end

      it 'continues to play the game' do
        expect(described_class).to receive(:play).at_least(:once)

        play_game
      end
    end

    context 'when dead' do
      before do
        allow(player).to receive(:alive?).and_return(false)
      end

      it 'ceases to continue the game' do
        expect(described_class).to receive(:play).once

        play_game
      end

      it 'exits the game' do
        expect(Kernel).to receive(:exit)

        play_game
      end
    end
  end
end
