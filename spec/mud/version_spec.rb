# frozen_string_literal: true

describe MUD do
  describe 'VERSION' do
    subject { MUD::VERSION }

    it { is_expected.to be_truthy }
  end
end
