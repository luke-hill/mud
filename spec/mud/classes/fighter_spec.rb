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
  let(:max_inventory_size) { subject.max_inventory_size }
  let(:mp) { subject.mp }
  let(:max_mp) { subject.max_mp }
  let(:strength) { subject.strength }
  let(:agility) { subject.agility }
  let(:resilience) { subject.resilience }
  let(:conjuring) { subject.conjuring }
  let(:attributes_quantity) { subject.instance_variable_get(:@attributes).length }

  describe 'initial starting stats' do
    it 'has 15 statistics in total' do
      expect(attributes_quantity).to eq(15)
    end

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

    it 'has 10 inventory slots' do
      expect(max_inventory_size).to eq(10)
    end

    it 'has 0 mp' do
      expect(mp).to eq(0)
    end

    it 'has 0 max mp' do
      expect(max_mp).to eq(0)
    end

    it 'has 10 strength' do
      expect(strength).to eq(10)
    end

    it 'has 7 agility' do
      expect(agility).to eq(7)
    end

    it 'has 8 resilience' do
      expect(resilience).to eq(8)
    end

    it 'has 5 conjuring' do
      expect(conjuring).to eq(5)
    end
  end
end
