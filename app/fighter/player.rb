module Fighter
  class Player
    attr_reader :attributes
    private :attributes

    attr_accessor :rooms_visited, :current_room

    extend Forwardable

    def_delegators :attributes, :name, :max_hp, :hp, :level, :stamina, :experience, :gold, :inventory
    def_delegators :attributes, :name=, :max_hp=, :hp=, :level=, :stamina=, :experience=, :gold=, :inventory=

    def initialize
      @attributes = Attributes.new
      @current_room = MUD::Rooms::Room.find(starting_room)
      @rooms_visited = {}
    end

    def starting_room
      1
    end
  end
end
