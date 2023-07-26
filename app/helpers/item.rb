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
    end
  end
end
