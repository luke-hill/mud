# frozen_string_literal: true

module SpecSupport
  module Factory
    def create(type, data)
      find_class(type).new(:no_op).tap do |model|
        model.instance_variable_set("@#{type}", OpenStruct.new(data))
      end
    end

    def create_null_enemy
      MUD::Enemy.of_type('null')
    end

    def create_dead_enemy
      MUD::Enemy.of_type('fully_equipped_dead')
    end

    def create_dummy_key
      MUD::Key.of_type('dummy')
    end

    def create_zero_armor
      MUD::Armor.of_type('zero')
    end

    def create_weapon(type = 'zero')
      MUD::Armor.of_type(type)
    end

    def create_potion(type)
      MUD::Potion.of_type(type)
    end

    def create_room(room_id)
      MUD::Room.new(room_id)
    end

    def create_shop(room_id)
      MUD::Shop.new(room_id)
    end

    private

    def find_class(type)
      "MUD::#{type.capitalize}".constantize
    end
  end
end
