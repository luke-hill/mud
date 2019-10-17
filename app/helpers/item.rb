module MUD
  module Helpers
    module Item
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
