# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#initialize' do
    it 'creates a player' do
      expect(subject.instance_variable_defined?(:@player)).to be true
    end
  end
end
