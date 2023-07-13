# frozen_string_literal: true

module MUD
  # The top level Weapon Class
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  class Weapon
    include Helpers::Data

    attr_accessor :id

    def self.of_type(type)
      new.tap do |weapon|
        weapon.id = type
      end
    end

    def self.properties
      %i[
        name
        description
        min_power
        max_power
      ]
    end

    properties.each do |property|
      define_method(property) do
        weapon_data[property.to_s]
      end
    end

    private

    def weapon_data
      weapon_yml[id] || raise("Weapon not found with ID: #{id}")
    end
  end
end
