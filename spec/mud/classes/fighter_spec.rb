# frozen_string_literal: true

RSpec.describe MUD::Classes::Fighter do
  subject(:fighter) { described_class.new }

  let(:attributes_quantity) { fighter.instance_variable_get(:@attributes).length }

  describe 'initial starting stats' do
    it 'has 15 statistics in total' do
      expect(attributes_quantity).to eq(15)
    end

    it 'has a name' do
      expect(fighter.name).to eq('Test Player')
    end

    it 'has 25 max hp' do
      expect(fighter.max_hp).to eq(25)
    end

    it 'has 25 hp' do
      expect(fighter.hp).to eq(25)
    end

    it 'has 1 stamina' do
      expect(fighter.stamina).to eq(1)
    end

    it 'is level 1' do
      expect(fighter.level).to eq(1)
    end

    it 'has no initial experience' do
      expect(fighter.experience).to eq(0)
    end

    it 'has 200 gold' do
      expect(fighter.gold).to eq(200)
    end

    it 'has no initial items' do
      expect(fighter.inventory).to eq([])
    end

    it 'has 10 inventory slots' do
      expect(fighter.max_inventory_size).to eq(10)
    end

    it 'has 0 mp' do
      expect(fighter.mp).to eq(0)
    end

    it 'has 0 max mp' do
      expect(fighter.max_mp).to eq(0)
    end

    it 'has 10 strength' do
      expect(fighter.strength).to eq(10)
    end

    it 'has 7 agility' do
      expect(fighter.agility).to eq(7)
    end

    it 'has 8 resilience' do
      expect(fighter.resilience).to eq(8)
    end

    it 'has 5 conjuring' do
      expect(fighter.conjuring).to eq(5)
    end
  end
end
