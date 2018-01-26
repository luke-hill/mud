require 'rails_helper'

RSpec.describe RoomController, type: :controller do
  before do
    create(:player, room: starting_room, room_id: 1)
    create(:room, room_id: 2, south: 1)
    create(:room, room_id: 3, east: 4)
    create(:room, room_id: 4, east: 3)
  end

  let(:starting_room) { create(:room, room_id: 1, north: 2) }

  describe 'Unimplemented Actions' do
    describe '#look_around' do
      it "currently does nothing as it's not implemented" do
        expect(subject.look_around).to eq('Not implemented yet')
      end
    end

    describe '#up' do
      it "currently does nothing as it's not implemented" do
        expect(subject.up).to eq('Not in active use')
      end
    end

    describe '#down' do
      it "currently does nothing as it's not implemented" do
        expect(subject.down).to eq('Not in active use')
      end
    end

    describe '#pickup_item' do
      it "currently does nothing as it's not implemented" do
        expect(subject.pickup_item).to eq('Not in active use')
      end
    end

    describe '#drop_item' do
      it "currently does nothing as it's not implemented" do
        expect(subject.drop_item).to eq('Not in active use')
      end
    end

    describe '#pickup_gold' do
      it "currently does nothing as it's not implemented" do
        expect(subject.pickup_gold).to eq('Not in active use')
      end
    end

    describe '#drop_gold' do
      it "currently does nothing as it's not implemented" do
        expect(subject.drop_gold).to eq('Not in active use')
      end
    end
  end

  describe 'Implemented Actions' do
    describe '#north' do
      context 'With an accessible room North' do
        before do
          p "Initial Room"
          p subject.current_player.room_id
          p "Attempting to derp room id to 2"
          subject.current_player.stub(:room_id).and_return(2)
          p "Derped"
          p subject.current_player.room_id
        end

        it "Informs you that you've moved North" do
          initial_room_id = subject.current_player.room_id

          expect(subject.north).to eq('You went North')

          expect(subject.current_player.room_id).not_to eq(initial_room_id)
        end
      end

      context 'Without a room North' do
        before { allow(subject).to receive(:north_room) { nil } }

        it "Informs you that you didn't move North" do
          expect(subject.north).to eq('No go')
        end
      end
    end

    describe '#south' do
      context 'With an accessible room South' do
        before do
          allow(subject).to receive(:south_room) { 2 }
          allow(subject.current_player).to receive(:update).with(room_id: 2)
        end

        it "Informs you that you've moved South" do
          expect(subject.south).to eq('You went South')
        end
      end

      context 'Without a room South' do
        before { allow(subject).to receive(:south_room) { nil } }

        it "Informs you that you didn't move South" do
          expect(subject.south).to eq('No go')
        end
      end
    end

    describe '#east' do
      context 'With an accessible room East' do
        before do
          allow(subject).to receive(:east_room) { 2 }
          allow(subject.current_player).to receive(:update).with(room_id: 2)
        end

        it "Informs you that you've moved East" do
          expect(subject.east).to eq('You went East')
        end
      end

      context 'Without a room East' do
        before { allow(subject).to receive(:east_room) { nil } }

        it "Informs you that you didn't move East" do
          expect(subject.east).to eq('No go')
        end
      end
    end

    describe '#west' do
      context 'With an accessible room West' do
        before do
          allow(subject).to receive(:west_room) { 2 }
          allow(subject.current_player).to receive(:update).with(room_id: 2)
        end

        it "Informs you that you've moved West" do
          expect(subject.west).to eq('You went West')
        end
      end

      context 'Without a room West' do
        before { allow(subject).to receive(:west_room) { nil } }

        it "Informs you that you didn't move West" do
          expect(subject.west).to eq('No go')
        end
      end
    end
  end
end
