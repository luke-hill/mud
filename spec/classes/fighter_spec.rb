RSpec.describe MUD::Classes::Fighter do
  let(:name)       { subject.name }
  let(:max_hp)     { subject.max_hp }
  let(:hp)         { subject.hp }
  let(:stamina)    { subject.stamina }
  let(:level)      { subject.level }
  let(:experience) { subject.experience }
  let(:gold)       { subject.gold }
  let(:inventory)  { subject.inventory }

  describe 'has initial starting stats for' do
    it { expect(name).to eq('Test Player') }
    it { expect(max_hp).to eq(25) }
    it { expect(hp).to eq(25) }
    it { expect(stamina).to eq(1) }
    it { expect(level).to eq(1) }
    it { expect(experience).to eq(0) }
    it { expect(gold).to eq(200) }
    it { expect(inventory).to eq([]) }
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
