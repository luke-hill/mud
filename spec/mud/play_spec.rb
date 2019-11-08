# frozen_string_literal: true

RSpec.describe MUD::Play do
  subject(:play_game) { play_class.play }

  let(:play_class) { described_class.new }
  let(:player) { MUD::Game.player }
  let(:alive?) { true }
  let(:user_input) { 'some_command' }

  before do
    allow(player).to receive(:alive?).and_return(alive?)
    allow($stdin).to receive(:gets).and_return(user_input)
  end

  context 'when player is alive' do
    it 'delegates input commands to the Command Action class' do
      expect(MUD::Actions::Command).to receive(:new).with(user_input).at_most(:once)

      Timeout.timeout(0.5) { play_game } rescue Exception
    end
  end

  context 'when player is dead' do
    let(:alive?) { false }

    it 'calls the die method and exits the game' do
      expect(play_class).to receive(:die)

      play_game
    end
  end
end
