# frozen_string_literal: true

RSpec.describe MUD::Armor do
  let(:armor) { create(:armor, armor_data) }
  let(:armor_data) do
    {
      name: 'Dummy Armor',
      description: 'A Description',
      defense: 1
    }
  end

  describe 'delegated methods' do
    data_keys = %i[
      name
      description
      defense
    ]
    data_keys.each do |key|
      it "delegates calling #{key} on the Armor class to the armor data" do
        expect(armor).to receive(:armor).and_call_original

        armor.send(key)
      end
    end
  end
end
