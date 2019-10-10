# frozen_string_literal: true

RSpec.describe Game, type: :classes do
  describe '#initialize' do
    it 'creates a player' do
      expect(subject.instance_variable_defined?(:@player)).to be true
    end
  end
end
