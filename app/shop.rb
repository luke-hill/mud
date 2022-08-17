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
      MUD::Logger.debug("Displaying Shop Data for Room-ID: #{room_id}")
      MUD::Screen.output(shop_items_string)
    end

    private

    def shop_items_string
      @shop_items_string ||= Presenters::ShopItems.new(room_id).string
    end

    def validate_enemy_not_present
      return unless enemy?

      MUD::Logger.debug("Enemy found: #{enemy.inspect}")
      raise "There shouldn't be any enemies in shops!"
    end
  end
end
