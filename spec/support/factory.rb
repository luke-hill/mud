# frozen_string_literal: true

module SpecSupport
  module Factory
    def create(thing, type)
      find_class(thing).of_type(type)
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
