# frozen_string_literal: true

RSpec.describe MUD::Helpers::Unabbreviater do
  let(:unabbreviater_helper) { klass.new }
  let(:klass) do
    Class.new do
      include MUD::Helpers::Unabbreviater
    end
  end

  describe '#unnabbreviate' do
    it 'can unabbreviate a direction to move in' do
      expect { unabbreviater_helper.unnabbreviate('n', type: :movement) }.not_to raise_error
    end

    it 'cannot unabbreviate anything else' do
      expect { unabbreviater_helper.unnabbreviate('nm', type: :not_movement) }
        .to raise_error
        .with_message('Unreachable code - Abbreviate request: nm')
    end
  end
end
