module World
  class Room
    def shop_menu
      puts '-----------------------------------'
      puts '| Lesser Healing Potion | 25 gold |'
      puts '-----------------------------------'
      puts '|   Endurance Potion   | 200 gold |'
      puts '-----------------------------------'
    end

    def no_key_on_floor?
      item_object_on_floor('Barracks Key').nil?
    end

    def item_object_on_floor(name)
      floor.detect do |item|
        item.name.downcase == name.downcase
      end
    end
  end
end
