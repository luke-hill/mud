# frozen_string_literal: true

module MUD
  # The top level Armor Class
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  class Armor
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :armor,
                   :name,
                   :description,
                   :defense

    private

    def armor
      @armor ||= OpenStruct.new(armor_data)
    end

    def armor_data
      armor_yml[id] || raise("Armor not found with ID: #{id}")
    end
  end
end
