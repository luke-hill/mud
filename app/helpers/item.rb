# frozen_string_literal: true

module MUD
  module Helpers
    # A List of all of the relevant Lookup Helpers for Item querying
    # For Item Lookup, use the +Helpers::Data+ Module
    module Item
      include Helpers::Data

      # @return [Array => String]
      # The list of all weapon_ids that are mapped in the yml database
      def weapon_ids
        weapon_yml.keys
      end

      # @return [Array => String]
      # The list of all armor_ids that are mapped in the yml database
      def armor_ids
        armor_yml.keys
      end

      # @return [Boolean]
      # Whether you have a barracks key in your inventory
      def barracks_key?
        !inventory.detect { |item| item == 'barracks_key' }.nil?
      end

      # @return [String]
      # The description of gold coins, this needs placing somewhere relevant or removing
      def gold_description
        'Glistening in your hand, these gold coins are trade-able at just about any shop.'
      end
    end
  end
end
