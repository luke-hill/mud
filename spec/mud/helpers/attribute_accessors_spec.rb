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

  describe '.attribute_names' do
    subject { described_class.attribute_names }

    it { is_expected.to eq(attribute_names) }
  end

  describe 'delegated methods' do

    subject(:player) { MUD::Classes::Fighter.new }
    let(:attributes) { player.instance_variable_get(:@attributes) }

    context 'reader methods' do
      it 'reads name through the attributes hash' do
        expect(attributes).to receive(:[]).with(:name)

        player.name
      end

      it 'reads level through the attributes hash' do
        expect(attributes).to receive(:[]).with(:level)

        player.level
      end

      it 'reads experience through the attributes hash' do
        expect(attributes).to receive(:[]).with(:experience)

        player.experience
      end

      it 'reads max_hp through the attributes hash' do
        expect(attributes).to receive(:[]).with(:max_hp)

        player.max_hp
      end

      it 'reads hp through the attributes hash' do
        expect(attributes).to receive(:[]).with(:hp)

        player.hp
      end

      it 'reads max_mp through the attributes hash' do
        expect(attributes).to receive(:[]).with(:max_mp)

        player.max_mp
      end

      it 'reads mp through the attributes hash' do
        expect(attributes).to receive(:[]).with(:mp)

        player.mp
      end

      it 'reads stamina through the attributes hash' do
        expect(attributes).to receive(:[]).with(:stamina)

        player.stamina
      end

      it 'reads strength through the attributes hash' do
        expect(attributes).to receive(:[]).with(:strength)

        player.strength
      end

      it 'reads agility through the attributes hash' do
        expect(attributes).to receive(:[]).with(:agility)

        player.agility
      end

      it 'reads resilience through the attributes hash' do
        expect(attributes).to receive(:[]).with(:resilience)

        player.resilience
      end

      it 'reads conjuring through the attributes hash' do
        expect(attributes).to receive(:[]).with(:conjuring)

        player.conjuring
      end

      it 'reads gold through the attributes hash' do
        expect(attributes).to receive(:[]).with(:gold)

        player.gold
      end

      it 'reads inventory through the attributes hash' do
        expect(attributes).to receive(:[]).with(:inventory)

        player.inventory
      end

      it 'reads max_inventory_size through the attributes hash' do
        expect(attributes).to receive(:[]).with(:max_inventory_size)

        player.max_inventory_size
      end
    end

    context 'writer methods' do
      it 'writes to name through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:name, 'Test')

        player.name = 'Test'
      end

      it 'writes to level through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:level, 3)

        player.level = 3
      end

      it 'writes to experience through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:experience, 3_000)

        player.experience = 3_000
      end

      it 'writes to max_hp through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:max_hp, 50)

        player.max_hp = 50
      end

      it 'writes to hp through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:hp, 5)

        player.hp = 5
      end

      it 'writes to max_mp through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:max_mp, 50)

        player.max_mp = 50
      end

      it 'writes to mp through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:mp, 5)

        player.mp = 5
      end

      it 'writes to stamina through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:stamina, 2)

        player.stamina = 2
      end

      it 'writes to strength through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:strength, 11)

        player.strength = 11
      end

      it 'writes to agility through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:agility, 11)

        player.agility = 11
      end

      it 'writes to resilience through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:resilience, 11)

        player.resilience = 11
      end

      it 'writes to conjuring through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:conjuring, 11)

        player.conjuring = 11
      end

      it 'writes to gold through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:gold, 250)

        player.gold = 250
      end

      it 'writes to inventory through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:inventory, ['knife'])

        player.inventory = ['knife']
      end

      it 'writes to max_inventory_size through the attributes hash' do
        expect(attributes).to receive(:[]=).with(:max_inventory_size, 8)

        player.max_inventory_size = 8
      end
    end
  end
end
