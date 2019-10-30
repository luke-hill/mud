# frozen_string_literal: true

module MUD
  class Shop < Room
    def buy(item_id)
      if for_sale?(item_id)
        if enough_money?(item_id)
          if enough_space?
            player.gold -= cost(item_id)
            player.inventory << item_id
          end

          MUD::Screen.output("You bought a #{item_id.blue} for #{cost(item_id).yellow} gold.")
        else
          MUD::Screen.output('You do not have enough gold for that.'.red)
        end
      else
        MUD::Screen.output("I'm sorry we dont have that item for sale")
      end
    end

    def cost(item_id)
      # We need a new database seeding of shop locations with items!
      # Lesser Healing Pots are 25 and Heal for 10 (That is it currently!)
      25
    end

    def enough_money?(item_id)
      MUD::Logger.debug("Current gold amount #{player.gold}")
      player.gold >= cost(item_id)
    end

    def enough_space?
      player.inventory.compact.length < player.max_inventory_size
    end

    def for_sale?(item_id)
      # We need the concept of what items are for sale where
      # For now this will be true for the 1 shop
      true
    end

    def enemy
      super
      return if no_enemy?

      MUD::Logger.debug("Enemy found: #{enemy.inspect}")
      raise RuntimeError, "There shouldn't be any enemies in shops!"
    end

    private

    def no_enemy?
      enemy.id == nil || enemy.id == 'no_enemy'
    end
  end
end
