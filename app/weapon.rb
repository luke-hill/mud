# frozen_string_literal: true

module MUD
  # The top level Weapon Class
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  class Weapon
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :weapon,
                   :name,
                   :description,
                   :min_power,
                   :max_power

    private

    def weapon
      @weapon ||= OpenStruct.new(weapon_data)
    end

    def weapon_data
      weapon_yml[id] || raise(RuntimeError, "Weapon not found with ID: #{id}")
    end
  end
end
