require 'rails_helper'

RSpec.describe Fighter::Player, type: :model do
  describe 'delegates to the attributes object' do
    context 'when reading' do
      it { should delegate_method(:name).to(:attributes) }

      it { should delegate_method(:max_hp).to(:attributes) }

      it { should delegate_method(:hp).to(:attributes) }

      it { should delegate_method(:stamina).to(:attributes) }

      it { should delegate_method(:level).to(:attributes) }

      it { should delegate_method(:experience).to(:attributes) }

      it { should delegate_method(:gold).to(:attributes) }

      it { should delegate_method(:inventory).to(:attributes) }
    end

    context 'when writing' do
      it { should delegate_method(:name=).to(:attributes) }

      it { should delegate_method(:max_hp=).to(:attributes) }

      it { should delegate_method(:hp=).to(:attributes) }

      it { should delegate_method(:stamina=).to(:attributes) }

      it { should delegate_method(:level=).to(:attributes) }

      it { should delegate_method(:experience=).to(:attributes) }

      it { should delegate_method(:gold=).to(:attributes) }

      it { should delegate_method(:inventory=).to(:attributes) }
    end
  end

  describe '#starting_room' do
    it 'is set' do
      expect(subject.room_id).to eq(1)
    end
  end
end
