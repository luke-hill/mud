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
      super
      validate_enemy_not_present
    end

    # @return [String]
    # This delegates to the Buy class and performs the #buy action
    def buy(item_id)
      Actions::Buy.new(item_id, self).buy
    end

    # @return [String]
    # A list of all items for sale
    # This uses the ShopItems presenter so it should be formatted neatly
    def items_for_sale
      Logger.debug("Displaying Shop Data for Room-ID: #{room_id}")
      Screen.output(shop_items_string)
    end

    # @return [Boolean]
    # Whether the item_id is for sale in the current shop
    def for_sale?(item_id)
      !price(item_id).nil?
    end

    # @return [Array => Integer]
    # A list of the costs of each item in the shop
    def potion_costs
      potion_data.map { |data| data['cost'] }
    end

    # @return Integer
    # The price of the specific item_id requested
    def price(item_id)
      find_item(item_id)&.fetch('cost', nil)
    end

    # @return [Array => String]
    # A list of the names of each item in the shop
    def potion_names
      potion_data.map { |data| data['id'] }
    end

    private

    def shop_items_string
      @shop_items_string ||= Presenters::ShopItems.new(self).string
    end

    def validate_enemy_not_present
      return unless enemy?

      Logger.debug("Enemy found: #{enemy.inspect}")
      raise "There shouldn't be any enemies in shops!"
    end

    def present?(item_id)
      potion_names.include?(item_id)
    end

    def find_item(item_id)
      potion_data.detect { |data| data['id'] == item_id }
    end

    def potion_data
      room_data['potions']
    end

    def room_data
      @room_data ||= shop_yml[room_id]
    end
  end
end
