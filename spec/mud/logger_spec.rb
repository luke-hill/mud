# frozen_string_literal: true

RSpec.describe MUD::Logger do
  subject { described_class }

  describe '.logger' do
    it 'is a Ruby ::Logger object' do
      expect(described_class.logger).to be_a Logger
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:debug).to(:logger) }
    it { is_expected.to delegate(:info).to(:logger) }
    it { is_expected.to delegate(:warn).to(:logger) }
    it { is_expected.to delegate(:error).to(:logger) }
    it { is_expected.to delegate(:fatal).to(:logger) }
    it { is_expected.to delegate(:unknown).to(:logger) }
  end
end
