# frozen_string_literal: true

RSpec.describe MUD::Helpers::Item do
  let(:item_helper) { klass.new }

  let(:klass) do
    Class.new do
      include MUD::Helpers::Item
    end
  end

  describe '#weapon_ids' do
    it 'outputs a list of the ids of all weapons that exist' do
      expect(item_helper.weapon_ids).to be_an Array
    end
  end

  describe '#armor_ids' do
    it 'outputs a list of the ids of all armors that exist' do
      expect(item_helper.armor_ids).to be_an Array
    end
  end

  describe '#gold_description' do
    it 'outputs the description of gold' do
      expect(item_helper.gold_description)
        .to eq('Glistening in your hand, these gold coins are trade-able at just about any shop.')
    end
  end
end
