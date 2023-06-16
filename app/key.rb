# frozen_string_literal: true

module MUD
  # The top level Key Class
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct.
  # All Data is stored in the games data yml files, which are seeded.
  class Key
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :key,
                   :name,
                   :use_message,
                   :description,
                   :missing_message

    private

    def key
      @key ||= OpenStruct.new(key_data)
    end

    def key_data
      key_yml[id] || raise("Key not found with ID: #{id}")
    end
  end
end
