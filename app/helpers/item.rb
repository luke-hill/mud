# frozen_string_literal: true

module MUD
  module Helpers
    module Item
      include Helpers::Data

      def weapon_ids
        weapon_yml.keys
      end

      def armor_ids
        armor_yml.keys
      end

      def barracks_key
        inventory.detect { |item| item.name == 'Barracks Key' }
      end

      def gold_description
        'Glistening in your hand, these gold coins are trade-able at just about any shop'
      end
    end
  end
end
