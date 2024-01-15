# frozen_string_literal: true

RSpec.describe MUD::Helpers::AttributeAccessors do
  let(:attribute_names) do
    %i[
      name
      level
      experience
      max_hp
      hp
      max_mp
      mp
      stamina
      strength
      agility
      resilience
      conjuring
      gold
      inventory
      max_inventory_size
    ]
  end
  let(:player) { MUD::Classes::Fighter.new }
  let(:attributes) { player.instance_variable_get(:@attributes) }

  describe '.attribute_names' do
    subject { described_class.attribute_names }

    it { is_expected.to eq(attribute_names) }
  end

  describe 'delegated reader methods' do
    %i[
      name
      level
      experience
      max_hp
      hp
      max_mp
      mp
      stamina
      strength
      agility
      resilience
      conjuring
      gold
      inventory
      max_inventory_size
    ].each do |attribute_name|
      it "reads #{attribute_name} through the attributes hash" do
        expect(attributes).to receive(:[]).with(attribute_name)

        player.public_send(attribute_name)
      end
    end
  end

  describe 'delegated writer methods' do
    [
      [:name, 'Test'],
      [:level, 3],
      [:experience, 3_000],
      [:max_hp, 50],
      [:hp, 5],
      [:max_mp, 50],
      [:mp, 5],
      [:stamina, 2],
      [:strength, 11],
      [:agility, 11],
      [:resilience, 11],
      [:conjuring, 11],
      [:gold, 250],
      [:inventory, ['knife']],
      [:max_inventory_size, 8]
    ].each do |attribute, value|
      it "writes to #{attribute} through the attributes hash" do
        expect(attributes).to receive(:[]=).with(attribute, value)

        player.public_send(:"#{attribute}=", value)
      end
    end
  end
end
