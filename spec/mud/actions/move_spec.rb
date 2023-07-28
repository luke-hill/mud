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

  context 'when trying to move through a locked door WITHOUT the required key' do
    let(:direction) { 'north' }

    before { player.current_room = MUD::Room.new('locked_room') }

    it 'does not let the player leave' do
      expect { move_attempt }.not_to(change { current_room_id })
    end

    it 'informs the player you need a key' do
      expect(MUD::Screen).to receive(:output).with("Oh dear, no key!".red)

      move_attempt
    end
  end

  context 'when trying to move through a locked door WITH the required key' do
    let(:direction) { 'north' }

    before do
      player.current_room = MUD::Room.new('locked_room')
      player.inventory << 'dummy'
    end

    it 'allows the player to move to the next room' do
      expect { move_attempt }.to change { current_room_id }.to('blank_room')
    end

    it 'uses up the key' do
      expect { move_attempt }.to change(player.inventory, :length).by(-1)
    end
  end
end
