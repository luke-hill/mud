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

      def missing_barracks_key
        'You are missing the key to the door that is blocking your passage. There are faint markings underneath the keyhole\
       that closely resemble the insignia of the Barracks'
      end
    end
  end
end
