RSpec.describe MUD::Classes::Fighter do
  let(:name)       { subject.name }
  let(:max_hp)     { subject.max_hp }
  let(:hp)         { subject.hp }
  let(:stamina)    { subject.stamina }
  let(:level)      { subject.level }
  let(:experience) { subject.experience }
  let(:gold)       { subject.gold }
  let(:inventory)  { subject.inventory }

  before do
    allow($stdout).to receive(:write).and_return nil
  end

  describe 'initial starting stats' do
    it 'has a name' do
      expect(name).to eq('Test Player')
    end

    it 'has 25 max hp' do
      expect(max_hp).to eq(25)
    end

    it 'has 25 hp' do
      expect(hp).to eq(25)
    end

    it 'has 1 stamina' do
      expect(stamina).to eq(1)
    end

    it 'is level 1' do
      expect(level).to eq(1)
    end

    it 'has no initial experience' do
      expect(experience).to eq(0)
    end

    it 'has 200 gold' do
      expect(gold).to eq(200)
    end

    it 'has no initial items' do
      expect(inventory).to eq([])
    end
  end

  describe '#current_room' do
    it 'returns what room you are in' do
      expect(subject.current_room).to be_a MUD::Rooms::Room
    end

    it 'is room 1 when starting a game' do
      expect(subject.current_room.room_id).to eq(1)
    end
  end
end
