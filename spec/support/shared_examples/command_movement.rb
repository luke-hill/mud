# frozen_string_literal: true

RSpec.shared_examples 'Command movement examples' do
  it 'attempts to move by delegating to the movement class' do
    expect(MUD::Actions::Move).to receive(:new).with(unnabbreviate(command_input, type: :movement)).and_call_original

    command.process
  end
end
