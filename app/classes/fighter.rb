module MUD
  module Classes
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
          inventory: []
        }
      end
    end
  end
end
