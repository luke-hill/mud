# frozen_string_literal: true

RSpec.describe MUD::Helpers::Data do
  describe '#player' do
    subject { klass.new.player }

    let(:klass) do
      Class.new do
        include MUD::Helpers::Data
      end
    end

    it { is_expected.to be_a(MUD::Classes::Base) }
  end
end
