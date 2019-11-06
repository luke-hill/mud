# frozen_string_literal: true

module Player
  class Avalanche
    def pickup_item(name)
      item = room.item_object_on_floor(name)
      return puts 'Item is not on floor' if item.nil?

      inventory << item
      puts "You picked up the #{name}"
      room.floor.delete(item)
    end
  end
end
