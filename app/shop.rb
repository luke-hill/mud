# frozen_string_literal: true

module MUD
  class Shop < Room
    def initialize(*args)
      super(*args)
      validate_enemy_not_present
    end

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

    def shop_items_string
      @shop_items_string ||= Presenters::ShopItems.new(room_id).string
    end

    private

    def validate_enemy_not_present
      return unless enemy?

      MUD::Logger.debug("Enemy found: #{enemy.inspect}")
      raise "There shouldn't be any enemies in shops!"
    end
  end
end
