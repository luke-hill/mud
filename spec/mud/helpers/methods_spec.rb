# frozen_string_literal: true

RSpec.describe MUD::Helpers::Methods do
  describe '#player' do
    subject { klass.new.player }

    let(:klass) do
      Class.new do
        include MUD::Helpers::Methods
      end
    end

    it { is_expected.to be_a(MUD::Classes::Base) }
  end
end
