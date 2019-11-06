# frozen_string_literal: true

RSpec.describe MUD::Actions::Move do
  before do
    swallow_console_spam
    switch_logging_to_temp_file
    allow(described_class).to receive(:connected_rooms) { connected_rooms }
  end

  after { reset_room }

  describe '#north' do
    let(:direction) { 'north'}
    include_examples 'Movement examples'
  end

  describe '#south' do
    let(:direction) { 'south'}
    include_examples 'Movement examples'
  end

  describe '#east' do
    let(:direction) { 'east'}
    include_examples 'Movement examples'
  end

  describe '#west' do
    let(:direction) { 'west'}
    include_examples 'Movement examples'
  end

  describe '#up' do
    let(:direction) { 'up'}
    include_examples 'Movement examples'
  end

  describe '#down' do
    let(:direction) { 'down'}
    include_examples 'Movement examples'
  end

  describe '#pickup_item' do
    it 'does not work' do
      expect(described_class.pickup_item).to eq('Not in active use'.red)
    end
  end

  describe '#drop_item' do
    it 'does not work' do
      expect(described_class.drop_item).to eq('Not in active use'.red)
    end
  end

  describe '#pickup_gold' do
    it 'does not work' do
      expect(described_class.pickup_gold).to eq('Not in active use'.red)
    end
  end

  describe '#drop_gold' do
    it 'does not work' do
      expect(described_class.drop_gold).to eq('Not in active use'.red)
    end
  end
end
