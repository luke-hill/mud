# frozen_string_literal: true

RSpec.describe MUD::Play do
  subject(:play_game) { described_class.new.play }

  let(:player) { MUD::Game.player }
  let(:user_input) { 'some_command' }

  before do
    allow($stdin).to receive(:gets).and_return(user_input)
    allow(Kernel).to receive(:exit)
    allow(MUD::Actions::Command).to receive(:new).with(user_input) { player.hp = 0 }
  end

  it 'delegates input commands to the Command Action class' do
    expect(MUD::Actions::Command).to receive(:new).with(user_input).and_call_original

    play_game
  end
end
