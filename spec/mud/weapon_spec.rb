# frozen_string_literal: true

RSpec.describe MUD::Weapon do
  let(:weapon) { create(:weapon, weapon_data) }
  let(:weapon_data) do
    {
      name: 'Dummy Weapon',
      description: 'A Description',
      min_power: 2,
      max_power: 4
    }
  end

  describe 'delegated methods' do
    data_keys = %i[
      name
      description
      min_power
      max_power
    ]
    data_keys.each do |key|
      it "delegates calling #{key} on the Weapon class to the weapon data" do
        expect(weapon).to receive(:weapon).and_call_original

        weapon.send(key)
      end
    end
  end
end
