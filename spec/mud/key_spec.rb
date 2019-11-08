# frozen_string_literal: true

RSpec.describe MUD::Key do
  subject(:key) { create(:key, key_data) }

  let(:key_data) do
    {
      name: 'Dummy Key',
      description: 'A Description',
      missing_message: 'Oh dear, no key!'
    }
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:name).to(:key) }
    it { is_expected.to delegate(:description).to(:key) }
    it { is_expected.to delegate(:missing_message).to(:key) }
  end
end
