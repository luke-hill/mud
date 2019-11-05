# frozen_string_literal: true

RSpec.describe MUD::Actions::Buy do
  subject(:buy_class) { described_class.new(hero, item_id) }

  let(:hero) do
    instance_double(
      MUD::Classes::Base,
      inventory: [],
      gold: 200,
      max_inventory_size: 10
    )
  end

  describe '#buy' do
    it 'logs the relevant attribute information to the game console' do
      player.view_attributes

      expect(log_lines.length).to be >= 8
    end
  end

  describe "delegated methods" do
    let(:item_id) { double }
    let(:args) { 1 }

    hero_methods = %i(inventory gold gold= max_inventory_size)
    hero_methods.each do |method|
      before { allow(described_class.new(hero, item_id)).to receive(method).with_options(args) }

      it "delegates #{method} to the hero" do
        expect(hero).to receive(method).with_options(*args)

        buy_class.send(method)
      end
    end
  end

  describe '#move' do
    it 'delegates to the Actions::Move class' do
      expect(MUD::Actions::Move).to receive(:south)

      player.move('south')
    end
  end

  describe '#prevent_negative_hp' do
    it 'prevents your hp from going negative' do
      player.hp = -3
      player.prevent_negative_hp
      expect(player.hp).to eq(0)
    end
  end

  context 'equipping items' do
    before { player.inventory << item_to_equip }

    let(:item_to_equip) { 'vest' }

    describe '#equip' do
      it 'can equip valid items' do
        expect { player.equip(item_to_equip) }.not_to raise_error
      end

      context 'an unrecognised item' do
        let(:item_to_equip) { 'unknown' }

        it 'will not equip the invalid item' do
          expect { player.equip(item_to_equip) }
            .to raise_error(RuntimeError)
                  .with_message("Cannot classify #{item_to_equip}.")
        end
      end
    end

    describe '#equipment' do
      it 'contains a hash of all currently equipped items' do
        expect(player.equipment.keys).to eq(%i(weapon armor))
      end
    end
  end

  describe '#rooms_visited=' do
    it 'can update the rooms you have visited' do
      expect(subject).to respond_to(:rooms_visited=)
    end
  end

  describe '#weapon' do
    before do
      player.inventory << item_to_equip
      player.equip(item_to_equip)
    end

    let(:item_to_equip) { 'knife' }

    it 'shows the id of the currently equipped weapon' do
      expect(player.weapon).to eq('knife')
    end
  end

  describe '#armor' do
    before do
      player.inventory << item_to_equip
      player.equip(item_to_equip)
    end

    let(:item_to_equip) { 'vest' }

    it 'shows the id of the currently equipped armor' do
      expect(player.armor).to eq('vest')
    end
  end
end
