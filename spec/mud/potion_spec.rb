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

  describe '#use_effect' do
    context 'when the potion is a "healing" potion' do
      before { allow(potion).to receive(:type).and_return(:healing) }

      it "returns a proc of the +hp use effect" do
        expect(potion.use_effect).to be_a Proc
      end
    end

    context 'when the potion is a "mana" potion' do
      before { allow(potion).to receive(:type).and_return(:mana) }

      it "returns a proc of the +mp use effect" do
        expect(potion.use_effect).to be_a Proc
      end
    end

    context 'when the potion is a "hp bonus" potion' do
      before { allow(potion).to receive(:type).and_return(:hp_bonus) }

      it "returns a proc of the +hp_max use effect" do
        expect(potion.use_effect).to be_a Proc
      end
    end
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
