# frozen_string_literal: true

module MUD
  class DirectionsPresenter
    include Helpers::Data

    attr_reader :room_id

    def initialize(room_id)
      @room_id = room_id
    end

    def string
      case visible_directions.length
      when 0; then 'You cannot move in any direction'
      when 1; then "You can only go #{visible_directions_as_string}"
      when 2..4; then "You can go #{visible_directions_as_string}"
      else raise "This room (Room-ID: #{room_id}), is incorrectly configured"
      end
    end

    private

    def visible_directions
      directions - hidden_directions
    end

    def directions
      initial_room_data.keys.select { |key| direction_types.include?(key) }
    end

    def initial_room_data
      direction_yml[room_id]
    end

    def direction_types
      %w[
        north
        south
        east
        west
      ]
    end

    def hidden_directions
      initial_room_data
        .map { |key, value| key.split('_').last if key.start_with?('hide') && value == true }
        .compact
    end

    def visible_directions_as_string
      visible_directions.to_sentence(last_word_connector: ' and ')
    end
  end
end
