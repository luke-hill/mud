require 'rails_helper'

RSpec.describe Fighter::Player, type: :model do
  describe 'delegates to the relevant attributes object' do
    context 'when reading' do
      it '#name' do
        expect { subject.name }.not_to raise_error
      end

      it '#max_hp' do
        expect { subject.max_hp }.not_to raise_error
      end

      it '#hp' do
        expect { subject.hp }.not_to raise_error
      end

      it '#stamina' do
        expect { subject.stamina }.not_to raise_error
      end

      it '#level' do
        expect { subject.level }.not_to raise_error
      end

      it '#experience' do
        expect { subject.experience }.not_to raise_error
      end

      it '#gold' do
        expect { subject.gold }.not_to raise_error
      end

      it '#inventory' do
        expect { subject.inventory }.not_to raise_error
      end
    end

    context 'when writing' do
      it '#name=' do
        expect { subject.name = 'New Test Player' }.not_to raise_error
      end

      it '#max_hp=' do
        expect { subject.max_hp = 26 }.not_to raise_error
      end

      it '#hp=' do
        expect { subject.hp = 26 }.not_to raise_error
      end

      it '#stamina=' do
        expect { subject.stamina = 2 }.not_to raise_error
      end

      it '#level=' do
        expect { subject.level = 2 }.not_to raise_error
      end

      it '#experience=' do
        expect { subject.experience = 100 }.not_to raise_error
      end

      it '#gold=' do
        expect { subject.gold = 250 }.not_to raise_error
      end

      it '#inventory=' do
        skip 'Have no items set yet'

        expect { subject.inventory = [] }.not_to raise_error
      end
    end
  end

  it 'has a starting room' do
    expect(subject.room_id).to eq(1)
  end
end
