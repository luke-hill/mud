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
        name_attributes
          .merge(experience_attributes)
          .merge(hp_mp_attributes)
          .merge(player_attributes)
          .merge(item_attributes)
      end

      def name_attributes
        {
          name: 'Test Player'
        }
      end

      def experience_attributes
        {
          level: 1,
          experience: 0
        }
      end

      def hp_mp_attributes
        {
          max_hp: 25,
          hp: 25,
          max_mp: 0,
          mp: 0
        }
      end

      def player_attributes
        {
          stamina: 1,
          strength: 10,
          agility: 7
        }
      end

      def item_attributes
        {
          gold: 200,
          inventory: [],
          max_inventory_size: 10
        }
      end
    end
  end
end
