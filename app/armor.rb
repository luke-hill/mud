# frozen_string_literal: true

module MUD
  # The top level Armor Class
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  class Armor
    include Helpers::Data

    attr_accessor :id

    def self.of_type(type)
      new.tap do |armor|
        armor.id = type
      end
    end

    def self.properties
      %i[
        name
        description
        defense
      ]
    end

    properties.each do |property|
      define_method(property) do
        armor_data[property.to_s]
      end
    end

    private

    def armor_data
      armor_yml[id] || raise("Armor not found with ID: #{id}")
    end
  end
end
