# frozen_string_literal: true

RSpec.describe MUD::Actions::Move do
  before { switch_logging_to_temp_file }

  after { remove_test_screen_logs }

  describe '#north' do
    let(:direction) { 'north' }

    include_examples 'Movement examples'
  end

  describe '#south' do
    let(:direction) { 'south' }

    include_examples 'Movement examples'
  end

  describe '#east' do
    let(:direction) { 'east' }

    include_examples 'Movement examples'
  end

  describe '#west' do
    let(:direction) { 'west' }

    include_examples 'Movement examples'
  end

  describe '#up' do
    let(:direction) { 'up' }

    include_examples 'Movement examples'
  end

  describe '#down' do
    let(:direction) { 'down' }

    include_examples 'Movement examples'
  end
end
