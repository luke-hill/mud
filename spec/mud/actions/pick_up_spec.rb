# frozen_string_literal: true

RSpec.describe MUD::Actions::PickUp do
  subject(:pick_up_instance) { described_class.new('demo_healing') }

  let(:player) { MUD::Game.player }

  before do
    allow(player.current_room).to receive(:floor).and_return(['demo_healing'])
  end

  describe '#pick_up' do
    subject(:pick_up_attempt) { pick_up_instance.pick_up }

    context "when the item isn't actually on the floor" do
      before do
        allow(player.current_room).to receive(:floor).and_return(['not_a_lesser_healing_potion'])
      end

      it "informs the player that the item isn't actually on the floor" do
        expect(pick_up_attempt).to eq("I'm sorry that item isn't on the floor".red)
      end

      it 'does not pick the item up' do
        expect { pick_up_attempt }.not_to change(player, :inventory)
      end
    end

    context "when the player doesn't have any more space for the item in his inventory" do
      before do
        allow(player).to receive(:max_inventory_size).and_return(0)
      end

      it 'informs the player that they cannot pick up the item' do
        expect(pick_up_attempt).to eq('You do not have enough space for that.'.red)
      end

      it 'does not pick the item up' do
        expect { pick_up_attempt }.not_to change(player, :inventory)
      end
    end

    context 'when the item is on the floor' do
      before { reset_inventory }

      it 'adds the item to the players inventory' do
        expect { pick_up_attempt }.to change(player.inventory, :length).by(1)
      end

      it 'removes the item from the floor' do
        expect { pick_up_attempt }.to change(player.current_room.floor, :length).by(-1)
      end
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:current_room).to(:player) }
    it { is_expected.to delegate(:inventory).to(:player) }
    it { is_expected.to delegate(:max_inventory_size).to(:player) }
  end
end
