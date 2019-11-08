# frozen_string_literal: true

RSpec.describe MUD::Key do
  let(:key) { create(:key, key_data) }
  let(:key_data) do
    {
      name: 'Dummy Key',
      description: 'A Description',
      missing_message: 'Oh dear, no key!'
    }
  end

  describe 'delegated methods' do
    data_keys = %i[
      name
      description
      missing_message
    ]
    data_keys.each do |data_key|
      it "delegates calling #{data_key} on the Key class to the key data" do
        expect(key).to receive(:key).and_call_original

        key.send(data_key)
      end
    end
  end
end
