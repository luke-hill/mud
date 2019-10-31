# frozen_string_literal: true

RSpec.describe MUD::Potion do
  let(:potion) { create(:potion, potion_data) }
  let(:potion_data) do
    {
      name: 'Dummy Potion',
      use_message: 'I been used!',
      description: 'A Description',
      value: 3
    }
  end

  describe 'delegated methods' do
    data_keys = %i[
      name
      use_message
      description
      value
    ]
    data_keys.each do |key|
      it "delegates calling #{key} on the Potion class to the potion data" do
        expect(potion).to receive(:potion).and_call_original

        potion.send(key)
      end
    end
  end
end
