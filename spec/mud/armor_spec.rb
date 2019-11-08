# frozen_string_literal: true

RSpec.describe MUD::Armor do
  subject(:armor) { create(:armor, armor_data) }

  let(:armor_data) do
    {
      name: 'Dummy Armor',
      description: 'A Description',
      defense: 1
    }
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:name).to(:armor) }
    it { is_expected.to delegate(:description).to(:armor) }
    it { is_expected.to delegate(:defense).to(:armor) }
  end
end
