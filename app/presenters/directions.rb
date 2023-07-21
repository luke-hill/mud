# frozen_string_literal: true

module MUD
  module Presenters
    # The Presentational Layer for showing Directions to the User
    #
    # This essentially will make a series of checks on the current room and its properties.
    # Based on the results of this, it will concatenate all directions and then present
    # them to the user to be used after the initial `description` or `advanced_description` string
    # has been outputted.
    class Directions
      include Helpers::Data

      attr_reader :room_id

      def initialize(room_id)
        @room_id = room_id
      end

      # @return [String]
      # The visible directions the user can see that they can travel
      #
      # NB: Sometimes directions are hidden, but the user can still travel in those directions
      def string
        case visible_directions.length
        when 0; then 'You cannot move in any direction'
        when 1; then "You can only go #{visible_directions_as_string}"
        when 2..6; then "You can go #{visible_directions_as_string}"
        else raise "This room (Room-ID: #{room_id}), is incorrectly configured"
        end
      end

      private

      def visible_directions_as_string
        visible_directions.to_sentence(last_word_connector: ' and ')
      end

      def visible_directions
        all_directions - hidden_directions
      end

      def all_directions
        room_data.keys & direction_types
      end

      def direction_types
        %w[
          north
          south
          east
          west
          up
          down
        ]
      end

      def hidden_directions
        room_data.filter_map { |key, value| key.split('_').last if key.start_with?('hide') && value == true }
      end

      def room_data
        @room_data ||= direction_yml[room_id]
      end
    end
  end
end
