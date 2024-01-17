# frozen_string_literal: true

RSpec.describe MUD::Helpers::Unabbreviater do
  subject(:unabbreviater_helper) { klass.new }

  let(:klass) do
    Class.new do
      include MUD::Helpers::Unabbreviater
    end
  end

  describe '#unabbreviate' do
    it 'can unabbreviate a direction to move in' do
      expect { unabbreviater_helper.unabbreviate('n', type: :movement) }.not_to raise_error
    end

    it 'cannot unabbreviate an invalid direction' do
      expect { unabbreviater_helper.unabbreviate('sw', type: :movement) }
        .to raise_error
        .with_message('Invalid unabbreviated movement request: sw')
    end

    it 'cannot unabbreviate anything else' do
      expect { unabbreviater_helper.unabbreviate('nm', type: :not_movement) }
        .to raise_error
        .with_message('Unreachable code - Unabbreviated request: nm')
    end
  end
end
