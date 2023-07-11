# frozen_string_literal: true

RSpec.describe MUD::Classes::Fighter do
  let(:attributes_quantity) { subject.instance_variable_get(:@attributes).length }

  describe 'initial starting stats' do
    it 'has 15 statistics in total' do
      expect(attributes_quantity).to eq(15)
    end

    it 'has a name' do
      expect(subject.name).to eq('Test Player')
    end

    it 'has 25 max hp' do
      expect(subject.max_hp).to eq(25)
    end

    it 'has 25 hp' do
      expect(subject.hp).to eq(25)
    end

    it 'has 1 stamina' do
      expect(subject.stamina).to eq(1)
    end

    it 'is level 1' do
      expect(subject.level).to eq(1)
    end

    it 'has no initial experience' do
      expect(subject.experience).to eq(0)
    end

    it 'has 200 gold' do
      expect(subject.gold).to eq(200)
    end

    it 'has no initial items' do
      expect(subject.inventory).to eq([])
    end

    it 'has 10 inventory slots' do
      expect(subject.max_inventory_size).to eq(10)
    end

    it 'has 0 mp' do
      expect(subject.mp).to eq(0)
    end

    it 'has 0 max mp' do
      expect(subject.max_mp).to eq(0)
    end

    it 'has 10 strength' do
      expect(subject.strength).to eq(10)
    end

    it 'has 7 agility' do
      expect(subject.agility).to eq(7)
    end

    it 'has 8 resilience' do
      expect(subject.resilience).to eq(8)
    end

    it 'has 5 conjuring' do
      expect(subject.conjuring).to eq(5)
    end
  end
end
