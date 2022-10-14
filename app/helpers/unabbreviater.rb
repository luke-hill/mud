# frozen_string_literal: true

module MUD
  module Helpers
    # A way of converting short-hand command inputs back into their verbose requirements
    module Unnabbreviater
      # @return String
      # Convert an input argument that's abbreviated into the verbose form
      # Requires an argument detailing the type
      def unnabbreviate(string, type:)
        case type
        when :movement; then unnabbreviate_movement(string)
        else raise "Unreachable code - Abbreviate request: #{string}"
        end
      end

      private

      def unnabbreviate_movement(string)
        case string
        when 'n', 'north'; then 'north'
        when 's', 'south'; then 'south'
        when 'e', 'east';  then 'east'
        when 'w', 'west';  then 'west'
        when 'u', 'up';    then 'up'
        when 'd', 'down';  then 'down'
        else raise "Unreachable code - Abbreviated movement request: #{string}"
        end
      end
    end
  end
end
