# frozen_string_literal: true

module MUD
  module Presenters
    # The Presentational Layer for showing Shop Items to the User
    #
    # This essentially will make a series of checks on the current room and its properties.
    # Based on the results of this, it will concatenate all items that should be available for
    # purchase and then present them to the user
    class ShopItems
      include Helpers::Data

      attr_reader :room_id, :shop

      def initialize(room_id, shop)
        @room_id = room_id
        @shop = shop
      end

      # @return [String]
      # The shop items that the user can see and purchase
      #
      # NB: Sometimes items are no longer for sale, but they are still presented to the user
      def string
        case potion_names.length
        when 1;   then simple_shop_menu
        when 2..; then complex_shop_menu
        else raise "This room (Room-ID: #{room_id}), is incorrectly configured"
        end
      end

      # deprecated
      def for_sale?(item_id)
        shop.for_sale?(item_id)
      end

      private

      def simple_shop_menu
        [
          dashed_string,
          array,
          dashed_string
        ].join("\n")
      end

      def complex_shop_menu
        [
          dashed_string,
          array.join("\n#{dashed_string}\n"),
          dashed_string
        ].join("\n")
      end

      def dashed_string
        # 3 for starting, middle and ending pipe
        # 1 for left padding
        # longest name
        # 5 for buffer name padding
        # 1 for right padding
        # 1 for left padding
        # 6 for buffer cost padding
        # longest cost
        # space gold is 5 chars
        # 1 extra char for the fact shortest value is 1
        # 1 for right padding
        '-' * (3 + 1 + longest_potion_name_length + 5 + 1 + 1 + 6 + longest_potion_cost_length + 5 + 1 + 1)
      end
      
      def array
        potion_names.map { |name| individual_item_string(name) }
      end

      def individual_item_string(name)
        if for_sale?(name)
          "| #{name}#{' ' * name_padding(name)} | #{' ' * cost_padding(price(name))} #{price(name)} gold |"
        else
          "| #{name}#{' ' * name_padding(name)} | (OUT OF STOCK) |"
        end
      end

      def name_padding(name = '')
        5 + longest_potion_name_length - name.length
      end

      def cost_padding(cost = 0)
        6 + longest_potion_cost_length - cost.digits.length
      end

      def longest_potion_name_length
        potion_names.map(&:length).max
      end

      def longest_potion_cost_length
        potion_costs.map { |cost| cost.to_i.digits.length }.max
      end

      # deprecated
      def price(item_id)
        shop.send(:price, item_id)
      end

      # deprecated
      def potion_names
        shop.send(:potion_names)
      end

      # deprecated
      def potion_costs
        shop.send(:potion_costs)
      end
    end
  end
end
