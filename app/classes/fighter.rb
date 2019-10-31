# frozen_string_literal: true

module MUD
  module Classes
    # The Fighter class
    # This is a Physical Hero, that mainly attacks using weapons and physical damage
    # It does not have access to MP as it cannot cast spells
    # It has the largest inventory of all of the classes
    # It starts off with the highest hp/stats
    class Fighter < Base
      def initialize
        @attributes = starting_attributes
        super
      end

      private

      def starting_attributes
        {
          name: 'Test Player',
          max_hp: 25,
          hp: 25,
          stamina: 1,
          level: 1,
          experience: 0,
          gold: 200,
          inventory: [],
          accuracy: 0.7,
          max_inventory_size: 10
        }
      end
    end
  end
end
