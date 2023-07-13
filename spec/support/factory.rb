# frozen_string_literal: true

module SpecSupport
  module Factory
    def create(type, data)
      find_class(type).new(:no_op).tap do |model|
        model.instance_variable_set("@#{type}", OpenStruct.new(data))
      end
    end

    def create_null_enemy
      SpecSupport::Enemy.of_type('null')
    end

    def create_dead_enemy
      SpecSupport::Enemy.of_type('fully_equipped_dead')
    end

    def create_dummy_key
      SpecSupport::Key.of_type('dummy')
    end

    def create_zero_armor
      SpecSupport::Armor.of_type('zero')
    end

    def create_room(room_id)
      SpecSupport::Room.new(room_id)
    end

    def create_shop(room_id)
      SpecSupport::Shop.new(room_id)
    end

    private

    def find_class(type)
      "MUD::#{type.capitalize}".constantize
    end
  end
end
