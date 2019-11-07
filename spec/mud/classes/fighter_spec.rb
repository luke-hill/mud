# frozen_string_literal: true

RSpec.describe MUD::Classes::Fighter do
  let(:name) { subject.name }
  let(:max_hp) { subject.max_hp }
  let(:hp) { subject.hp }
  let(:stamina) { subject.stamina }
  let(:level) { subject.level }
  let(:experience) { subject.experience }
  let(:gold) { subject.gold }
  let(:inventory) { subject.inventory }
  let(:accuracy) { subject.accuracy }
  let(:max_inventory_size) { subject.max_inventory_size }
  let(:mp) { subject.mp }

  before { swallow_console_spam }

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

    it 'has an accuracy rating of 0.7' do
      expect(accuracy).to eq(0.7)
    end

    it 'has 10 inventory slots' do
      expect(max_inventory_size).to eq(10)
    end

    it 'has 0 mp' do
      expect(mp).to eq(0)
    end
  end
end
