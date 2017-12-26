module Fighter
  class Player
    attr_accessor :room

    extend Forwardable

    def_delegators :@attributes, :name, :max_hp, :hp, :level, :stamina, :experience, :gold, :inventory
    def_delegators :@attributes, :name=, :max_hp=, :hp=, :level=, :stamina=, :experience=, :gold=, :inventory=

    def initialize
      @attributes = Attributes.new
      @room = starting_room
    end

    def starting_room
      Room.find_by_room_id(1)
    end
  end
end
