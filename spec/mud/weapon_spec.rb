# frozen_string_literal: true

RSpec.describe MUD::Weapon do
  subject(:weapon) { create(:weapon, weapon_data) }

  let(:weapon_data) do
    {
      name: 'Dummy Weapon',
      description: 'A Description',
      min_power: 2,
      max_power: 4
    }
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:name).to(:weapon) }
    it { is_expected.to delegate(:description).to(:weapon) }
    it { is_expected.to delegate(:min_power).to(:weapon) }
    it { is_expected.to delegate(:max_power).to(:weapon) }
  end
end
