# frozen_string_literal: true

module MUD
  # The top level Shop Class
  # This acts a bit like ActiveRecord, and will load the room into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  #
  # This inherits from the Room class, with some additional validations in place to ensure the "Shop" behaviour is
  # available for the player. Alongside this, the traditional Room properties/booleans are also available
  class Shop < Room
    def initialize(*args)
      super(*args)
      validate_enemy_not_present
    end

    def buy(item_id)
      Actions::Buy.new(player, item_id, self).buy
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
