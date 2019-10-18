RSpec.describe MUD::Classes::Base do
  before do
    # Mock sample player
    allow(player).to receive(:attributes).and_return(starting_attributes)
    # Mock loaded items
    allow(player).to receive(:weapon_ids).and_return(%w(fists knife))
    allow(player).to receive(:armor_ids).and_return(%w(unarmored vest))
    # Remove console spam
    swallow_console_spam
  end

  before(:each) { switch_logging_to_temp_file }
  after(:each) { remove_test_screen_logs }

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

  describe '#move' do
    it 'delegates to the Movement::Move class' do
      expect(MUD::Movement::Move).to receive(:south)

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

  context 'equipping items' do
    before { player.inventory << item_to_equip }

    let(:item_to_equip) { 'vest' }

    describe '#equip' do
      it 'can equip valid items' do
        expect { player.equip(item_to_equip) }.not_to raise_error
      end

      context 'an unrecognised item' do
        let(:item_to_equip) { 'unknown' }

        it 'will not equip the invalid item' do
          expect { player.equip(item_to_equip) }
            .to raise_error(RuntimeError)
            .with_message("Cannot classify #{item_to_equip}.")
        end
      end
    end

    describe '#equipment' do
      it 'contains a hash of all currently equipped items' do
        expect(player.equipment.keys).to eq(%i(weapon armor))
      end
    end
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(subject.current_room).to be_a MUD::Room
    end

    it 'is room 1 when starting a game' do
      expect(subject.current_room.room_id).to eq(1)
    end
  end

  describe '#current_room=' do
    it 'can update the current_room' do
      expect(subject).to respond_to(:current_room=)
    end
  end

  describe '#rooms_visited' do
    it 'returns what rooms you have visited' do
      expect(subject.rooms_visited).to be_a Hash
    end

    it 'is blank when starting a game' do
      expect(subject.rooms_visited).to eq({})
    end
  end

  describe '#rooms_visited=' do
    it 'can update the rooms you have visited' do
      expect(subject).to respond_to(:rooms_visited=)
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
end
