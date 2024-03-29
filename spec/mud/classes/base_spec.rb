# frozen_string_literal: true

RSpec.describe MUD::Classes::Base do
  before do
    allow(player).to receive_messages(attributes: starting_attributes, current_room: MUD::Room.new('blank_room'))
  end

  let(:starting_attributes) do
    {
      name: 'Test Player',
      max_hp: 25,
      hp: 25,
      max_mp: 0,
      mp: 0,
      stamina: 1,
      level:,
      experience: 0,
      gold: 200,
      inventory: ['zero'],
      max_inventory_size: 10,
      strength: 10,
      agility: 10,
      resilience: 10,
      conjuring: 10
    }
  end
  let(:player) { described_class.new }
  let(:level) { 1 }

  describe '#look_around' do
    it 'shows you the advanced description of the area' do
      expect(player.current_room).to receive(:advanced_description)

      player.look_around
    end
  end

  describe '#view_attributes' do
    it 'logs the relevant attribute information to the game console' do
      player.view_attributes

      expect(log_lines.length).to eq(15)
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
    let(:move_instance) { MUD::Actions::Move.new('south') }

    before do
      allow(MUD::Actions::Move).to receive(:new).with('south').and_return(move_instance)
      allow(move_instance).to receive(:player).and_return(player)
    end

    it 'delegates to the `Actions::Move` class' do
      expect(MUD::Actions::Move).to receive(:new).with('south')

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

  describe '#prevent_overflow_hp' do
    it 'prevents your hp from going over your max amount' do
      player.hp = 26
      player.prevent_overflow_hp

      expect(player.hp).to eq(25)
    end
  end

  describe '#prevent_negative_mp' do
    it 'prevents your hp from going negative' do
      player.mp = -3
      player.prevent_negative_mp

      expect(player.mp).to eq(0)
    end
  end

  describe '#prevent_overflow_mp' do
    it 'prevents your mp from going over your max amount' do
      player.mp = 26
      player.prevent_overflow_mp

      expect(player.mp).to eq(0)
    end
  end

  describe '#equip' do
    let(:equip_instance) { MUD::Actions::Equip.new('zero') }

    before do
      allow(MUD::Actions::Equip).to receive(:new).with('zero').and_return(equip_instance)
      allow(equip_instance).to receive(:player).and_return(player)
    end

    it 'delegates to the `Actions::Equip` class' do
      expect(MUD::Actions::Equip).to receive(:new).with('zero')

      player.equip('zero')
    end
  end

  describe '#use' do
    let(:use_instance) { MUD::Actions::Use.new('demo_healing') }

    before do
      allow(MUD::Actions::Use).to receive(:new).with('demo_healing').and_return(use_instance)
      allow(use_instance).to receive(:player).and_return(player)
    end

    it 'delegates to the `Actions::Use` class' do
      expect(MUD::Actions::Use).to receive(:new).with('demo_healing')

      player.use('demo_healing')
    end
  end

  describe '#fight' do
    let(:fight_instance) { MUD::Combat::Fight.new(player.current_room.enemy) }

    before do
      allow(player).to receive(:current_room).and_return(MUD::Room.new('filled_room'))
      allow(MUD::Combat::Fight).to receive(:new).with(player.current_room.enemy).and_return(fight_instance)
      allow(MUD::Game).to receive(:player).and_return(player)
      player.equip('zero')
    end

    it 'delegates to the `Combat::Fight` class' do
      expect(MUD::Combat::Fight).to receive(:new).with(player.current_room.enemy)

      player.fight(1)
    end
  end

  describe '#weapon' do
    it 'shows the id of the currently equipped weapon' do
      expect(player.weapon).to be_a MUD::Weapon
    end
  end

  describe '#armor' do
    it 'shows the id of the currently equipped armor' do
      expect(player.armor).to be_a MUD::Armor
    end
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(player.current_room).to be_a MUD::Room
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
      expect(player.rooms_visited).to be_empty
    end
  end

  describe '#rooms_visited=' do
    it 'can update the rooms you have visited' do
      expect(player).to respond_to(:rooms_visited=)
    end
  end

  describe '#accuracy' do
    subject { player.accuracy.round(2) }

    it { is_expected.to eq(0.27) }

    context 'when player is level 5' do
      let(:level) { 5 }

      it { is_expected.to eq(0.67) }
    end

    context 'when player is level 10' do
      let(:level) { 10 }

      it { is_expected.to eq(0.81) }
    end
  end
end
