module MUD
  module Classes
    module Fighter
      class Attributes
        attr_accessor :name, :max_hp, :hp, :stamina, :level, :experience, :gold, :inventory

        def initialize
          @name = 'Test Player'
          @max_hp = 25
          @hp = max_hp
          @stamina = 1
          @level = 1
          @experience = 0
          @gold = 200
          @inventory = []
        end
      end
    end
  end
end
