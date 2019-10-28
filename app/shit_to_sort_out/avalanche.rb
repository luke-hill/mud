# frozen_string_literal: true

module Player
  class Avalanche
    attr_accessor :accuracy

    def initialize
      @accuracy = 0.85
    end

    def buy(item)
      return puts "I'm sorry we dont have that item for sale" unless room.list_of_items_for_sale.include?(item)

      if item == 'Lesser Healing Potion' && gold > 25
        inventory << Items::Potion::LesserPotion.new
        self.gold -= 25
        puts "You bought a #{item} for 25 gold"
      elsif item == 'Endurance Potion' && gold > 200
        inventory << Items::Potion::EndurancePotion.new
        self.gold -= 200
        puts "You bought a #{item} for 200 gold"
      else
        puts 'You do not have enough gold for that.'
      end
    end

    def enemy_present?
      room.enemy_alive?
    end

    def all_gold_items
      room.floor.select { |item| item.name == 'Gold' }
    end

    def total_gold_on_floor
      all_gold_items.map(&:amount).sum
    end

    def pickup_gold
      amount = total_gold_on_floor
      @gold += amount
      item = room.item_object_on_floor('Gold')
      room.floor.delete(item)
      puts "You picked up #{amount} gold"
    end

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

      if enemy_present?
        puts cannot_leave_whilst_enemy_alive
      end
    end

    def west
      if enemy_present?
        puts cannot_leave_whilst_enemy_alive
      end
    end

    def cannot_leave_whilst_enemy_alive
      "You must kill the #{enemy_name} before leaving the room!"
    end
  end
end
