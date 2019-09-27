module Fighter
  class Player
    attr_reader :attributes
    private :attributes

    attr_accessor :current_room

    extend Forwardable

    def_delegators :attributes, :name, :max_hp, :hp, :level, :stamina, :experience, :gold, :inventory
    def_delegators :attributes, :name=, :max_hp=, :hp=, :level=, :stamina=, :experience=, :gold=, :inventory=

    def initialize
      @attributes = MUD::Classes::Fighter::Attributes.new
      @current_room = MUD::Rooms::Room.new(starting_room)
    end

    def starting_room
      1
    end
  end
end
