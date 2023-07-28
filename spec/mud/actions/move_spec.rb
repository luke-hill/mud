# frozen_string_literal: true

RSpec.describe MUD::Actions::Move do
  subject(:move_attempt) { described_class.new(direction).move }

  let(:player) { MUD::Game.player }

  describe '#north' do
    let(:direction) { 'north' }

    include_examples 'Movement examples'
  end

  describe '#south' do
    let(:direction) { 'south' }

    include_examples 'Movement examples'
  end

  describe '#east' do
    let(:direction) { 'east' }

    include_examples 'Movement examples'
  end

  describe '#west' do
    let(:direction) { 'west' }

    include_examples 'Movement examples'
  end

  describe '#up' do
    let(:direction) { 'up' }

    include_examples 'Movement examples'
  end

  describe '#down' do
    let(:direction) { 'down' }

    include_examples 'Movement examples'
  end

  context 'when the room has a ktp enemy still alive' do
    let(:direction) { 'north' }

    before { player.current_room = MUD::Room.new('enemy_ktp_room') }

    it 'does not let the player leave the room' do
      expect { move_attempt }.not_to(change { current_room_id })
    end

    it 'informs the player you must kill the present enemy before leaving' do
      expect(MUD::Screen).to receive(:output).with("You must kill the #{player.current_room.enemy.name} before leaving the room!".red)

      move_attempt
    end
  end
end
