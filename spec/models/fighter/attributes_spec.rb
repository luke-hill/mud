require 'rails_helper'

RSpec.describe Fighter::Attributes, type: :model do
  describe 'initially consists of' do
    it 'name' do
      expect(subject.name).to eq('Test Player')
    end

    it 'maximum hp' do
      expect(subject.max_hp).to eq(25)
    end

    it 'hp' do
      expect(subject.hp).to eq(25)
    end

    it 'stamina' do
      expect(subject.stamina).to eq(1)
    end

    it 'level' do
      expect(subject.level).to eq(1)
    end

    it 'experience' do
      expect(subject.experience).to eq(0)
    end

    it 'gold' do
      expect(subject.gold).to eq(200)
    end

    it 'an inventory' do
      expect(subject.inventory).to eq([])
    end
  end
end
