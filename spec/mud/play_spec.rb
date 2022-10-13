# frozen_string_literal: true

RSpec.describe MUD::Play do
  subject(:play_game) { play_instance.play }

  let(:play_instance) { described_class.new }
  let(:player) { MUD::Game.player }
  let(:user_input) { 'some_command' }
  let(:command_instance) { MUD::Actions::Command.new(user_input) }

  before do
    allow($stdin).to receive(:gets).and_return(user_input)
    allow(MUD::Game).to receive(:display_welcome_message)
    allow(MUD::Actions::Command).to receive(:new).with(user_input).and_return(command_instance)
  end

  describe '#play' do
    context 'when alive' do
      before do
        allow(player).to receive(:alive?).and_return(true, false)
        allow(Kernel).to receive(:exit)
      end

      it 'delegates input commands to the `MUD::Actions::Command` class' do
        expect(command_instance).to receive(:process).at_least(:once)

        play_game
      end

      it 'will continue to play the game' do
        expect(play_instance).to receive(:play).at_least(:once)

        play_game
      end
    end

    context 'when dead' do
      before do
        allow(player).to receive(:alive?).and_return(false)
      end

      it 'will cease to continue the game' do
        expect(play_instance).to receive(:play).once

        play_game
      end

      it 'will exit the game' do
        expect(Kernel).to receive(:exit)

        play_game
      end
    end
  end
end
