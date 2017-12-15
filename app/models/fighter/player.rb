module Fighter
  class Player
    attr_accessor :hp, :level, :stamina, :experience, :gold, :inventory, :room
    attr_reader :name, :max_hp

    def initialize(name)
      @name = name
      @max_hp = 25
      @hp = max_hp
      @level = 1
      @stamina = 1
      @experience = 0
      @gold = 200
      @inventory = []
      @room = starting_room
    end

    def starting_room
      Room.find_by_room_id(1)
    end
  end
end
