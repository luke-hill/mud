# frozen_string_literal: true

RSpec.describe MUD::Classes::Fighter do
  subject(:hero) { described_class.new }

  let(:attributes_quantity) { hero.instance_variable_get(:@attributes).length }

  describe 'initial starting stats' do
    it 'has 15 statistics in total' do
      expect(attributes_quantity).to eq(15)
    end

    it 'has a name' do
      expect(hero.name).to eq('Test Player')
    end

    it 'has 25 max hp' do
      expect(hero.max_hp).to eq(25)
    end

    it 'has 25 hp' do
      expect(hero.hp).to eq(25)
    end

    it 'has 1 stamina' do
      expect(hero.stamina).to eq(1)
    end

    it 'is level 1' do
      expect(hero.level).to eq(1)
    end

    it 'has no initial experience' do
      expect(hero.experience).to eq(0)
    end

    it 'has 200 gold' do
      expect(hero.gold).to eq(200)
    end

    it 'has no initial items' do
      expect(hero.inventory).to eq([])
    end

    it 'has 10 inventory slots' do
      expect(hero.max_inventory_size).to eq(10)
    end

    it 'has 0 mp' do
      expect(hero.mp).to eq(0)
    end

    it 'has 0 max mp' do
      expect(hero.max_mp).to eq(0)
    end

    it 'has 10 strength' do
      expect(hero.strength).to eq(10)
    end

    it 'has 7 agility' do
      expect(hero.agility).to eq(7)
    end

    it 'has 8 resilience' do
      expect(hero.resilience).to eq(8)
    end

    it 'has 5 conjuring' do
      expect(hero.conjuring).to eq(5)
    end
  end
end
