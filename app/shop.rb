# frozen_string_literal: true

module MUD
  class Shop < Room
    def buy(item_id)
      Actions::Buy.new(player, item_id).buy
    end

    def items_for_sale
      # This needs altering as well to be more variant and read from the DB
      MUD::Screen.output('-------------------------------------------------')
      MUD::Screen.output('|       Lesser Healing Potion        |  25 gold |')
      MUD::Screen.output('-------------------------------------------------')
      MUD::Screen.output('|   Endurance Potion (OUT OF STOCK)  | 200 gold |')
      MUD::Screen.output('-------------------------------------------------')
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
