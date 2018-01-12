module Fighter
  class Player
    attr_accessor :room_id
    attr_reader :attributes
    private :attributes

    extend Forwardable

    def_delegators :attributes, :name, :max_hp, :hp, :level, :stamina, :experience, :gold, :inventory
    def_delegators :attributes, :name=, :max_hp=, :hp=, :level=, :stamina=, :experience=, :gold=, :inventory=

    def initialize
      @attributes = Attributes.new
      @room_id = starting_room
    end

    def starting_room
      1
    end
  end
end
