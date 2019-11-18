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
    allow(command_instance).to receive(:process)
    allow(play_instance).to receive(:continue_or_die)
  end

  it 'delegates input commands to the `MUD::Actions::Command` class' do
    expect(MUD::Actions::Command).to receive(:new).with(user_input)

    play_game
  end
end
