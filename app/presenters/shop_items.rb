# frozen_string_literal: true

module MUD
  module Presenters
    # The Presentational Layer for showing Shop Items to the User
    #
    # This essentially will make a series of checks on the current room and its properties.
    # Based on the results of this, it will concatenate all items that should be available for
    # purchase and then present them to the user after the `advanced_description` string has
    # been outputted.
    class ShopItems
      include Helpers::Data

      attr_reader :room_id

      def initialize(room_id)
        @room_id = room_id
      end

      # @return [String]
      # The shop items that the user can see and purchase
      #
      # NB: Sometimes items are no longer for sale, but they are still presented to the user
      def string
        raise "This room (Room-ID: #{room_id}), is incorrectly configured"
      end

      private

      def for_sale?(item_id)
        !price(item_id).nil?
      end

      def price(item_id)
        initial_room_data.dig(room_id, item_id, 'price')
      end

      def initial_room_data
        shop_yml[room_id]
      end
    end
  end
end
