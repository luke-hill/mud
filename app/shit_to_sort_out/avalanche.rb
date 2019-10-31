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

    def use_potion
      return puts "You don't have any potions" if inventory.empty?

      inventory.first.use(self)
      inventory.delete_at(0)
    end

    def use_key
      puts 'You hear a click as you turn the key. The door slowly opens'
      inventory.delete(barracks_key)
    end

    def east
      if !key?
        return puts missing_key
      else
        use_key
      end

      puts cannot_leave_whilst_enemy_alive if enemy?
    end

    def cannot_leave_whilst_enemy_alive
      "You must kill the #{enemy_name} before leaving the room!"
    end
  end
end
