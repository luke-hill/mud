# frozen_string_literal: true

RSpec.describe MUD::Actions::Move do
  before do
    swallow_console_spam
    switch_logging_to_temp_file
    allow(described_class).to receive(:connected_rooms) { connected_rooms }
  end

  after { reset_room }

  let(:new_room_id) { 2 }

  describe '#north' do
    let(:direction) { 'north'}
    include_examples "Movement examples"
  end

  describe '#south' do
    let(:direction) { 'south'}
    include_examples "Movement examples"
  end

  def current_room_id
    MUD::Game.player.current_room.room_id
  end

  def reset_room
    MUD::Game.player.current_room = MUD::Room.new(1)
  end
end
