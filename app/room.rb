module MUD
  class Room
    include Helpers::Data
    include ActionView::Helpers

    attr_reader :room_id
    attr_accessor :times_visited, :floor

    def initialize(room_id)
      @room_id = room_id
      @times_visited = 0
      @floor = []
    end

    def connected_rooms
      @connected_rooms ||= direction_yml[room_id]
    end

    def description
      @description ||= "#{description_yml.dig(room_id, 'description').blue}\n#{directions_string.yellow}"
    end

    def advanced_description
      @advanced_description ||= description_yml.dig(room_id, 'advanced_description')
    end

    def directions_string
      @directions_string ||= begin
        case visible_directions.length
        when 0; then "You cannot move in any direction"
        when 1; then "You can only go #{visible_directions_as_string}"
        when 2..4; then "You can go #{visible_directions_as_string}"
        else raise RuntimeError, "This room is incorrectly configured"
        end
      end
    end

    def visit
      MUD::Logger.debug("Visiting Room-ID: #{room_id} Description: #{description}")
      MUD::Screen.output(description)
      self.times_visited += 1
    end

    def leave
      player.rooms_visited[room_id] = self
    end

    private

    def visible_directions
      connected_rooms.keys
    end

    def visible_directions_as_string
      visible_directions.to_sentence(last_word_connector: ' and ')
    end
  end
end
