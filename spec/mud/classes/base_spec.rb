# frozen_string_literal: true

RSpec.describe MUD::Classes::Base do
  before do
    allow(player).to receive(:attributes).and_return(starting_attributes)
    allow(player).to receive(:weapon_ids).and_return(%w[fists knife])
    allow(player).to receive(:armor_ids).and_return(%w[unarmored vest])
    swallow_console_spam
    switch_logging_to_temp_file
  end

  after { remove_test_screen_logs }

  let(:starting_attributes) do
    {
      name: 'Test Player',
      max_hp: 25,
      hp: 25,
      stamina: 1,
      level: 1,
      experience: 0,
      gold: 200,
      inventory: []
    }
  end
  let(:player) { described_class.new }

  describe '#look_around' do
    it 'shows you the advanced description of the area' do
      expect(player.current_room).to receive(:advanced_description)

      player.look_around
    end
  end

  describe '#view_attributes' do
    it 'logs the relevant attribute information to the game console' do
      player.view_attributes

      expect(log_lines.length).to be >= 8
    end
  end

  describe '#alive?' do
    subject { player.alive? }

    context 'when a player has more than 0 hp' do
      it { is_expected.to be true }
    end

    context 'when a player has 0 hp' do
      before { allow(player).to receive(:hp).and_return(0) }

      it { is_expected.to be false }
    end
  end

  describe '#dead?' do
    subject { player.dead? }

    context 'when a player has more than 0 hp' do
      it { is_expected.to be false }
    end

    context 'when a player has 0 or less hp' do
      before { allow(player).to receive(:hp).and_return(0) }

      it { is_expected.to be true }
    end
  end

  describe '#move' do
    it 'delegates to the `Actions::Move` class' do
      expect(MUD::Actions::Move).to receive(:new).with(player, 'south').and_call_original

      player.move('south')
    end
  end

  describe '#prevent_negative_hp' do
    it 'prevents your hp from going negative' do
      player.hp = -3
      player.prevent_negative_hp
      expect(player.hp).to eq(0)
    end
  end

  describe '#equip' do
    it 'delegates to the `Actions::Equip` class' do
      expect(MUD::Actions::Equip).to receive(:new).with(player, 'knife').and_call_original

      player.equip('knife')
    end
  end

  describe '#weapon' do
    before do
      player.inventory << item_to_equip
      player.equip(item_to_equip)
    end

    let(:item_to_equip) { 'knife' }

    it 'shows the id of the currently equipped weapon' do
      expect(player.weapon).to eq('knife')
    end
  end

  describe '#armor' do
    before do
      player.inventory << item_to_equip
      player.equip(item_to_equip)
    end

    let(:item_to_equip) { 'vest' }

    it 'shows the id of the currently equipped armor' do
      expect(player.armor).to eq('vest')
    end
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(player.current_room).to be_a MUD::Room
    end

    it 'is room 1 when starting a game' do
      expect(player.current_room.room_id).to eq(1)
    end
  end

  describe '#current_room=' do
    it 'can update the current_room' do
      expect(player).to respond_to(:current_room=)
    end
  end

  describe '#rooms_visited' do
    it 'returns what rooms you have visited' do
      expect(player.rooms_visited).to be_a Hash
    end

    it 'is blank when starting a game' do
      expect(player.rooms_visited).to eq({})
    end
  end

  describe '#rooms_visited=' do
    it 'can update the rooms you have visited' do
      expect(player).to respond_to(:rooms_visited=)
    end
  end
end
