# frozen_string_literal: true

module MUD
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct
  #
  # All Data is stored in the games data yml files, which are seeded
  class Key
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :key,
                   :name,
                   :description,
                   :missing_message

    def use_message
      key.use_message || fallback_message
    end

    private

    def fallback_message
      Logger.error("ERROR: Missing use_message on key. key_id: #{id}")
      'ERROR: Unknown Key - Will use up and continue.'
    end

    def key
      @key ||= OpenStruct.new(key_data)
    end

    def key_data
      key_yml[id] || raise("Key not found with ID: #{id}")
    end
  end
end
