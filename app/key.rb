# frozen_string_literal: true

module MUD
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct
  #
  # All Data is stored in the games data yml files, which are seeded
  class Key
    include Helpers::Data

    attr_accessor :id

    # @return [MUD::Key]
    # Return an instance of key class with correct id set
    def self.of_type(type)
      new.tap do |key|
        key.id = type
      end
    end

    # @return [Array]
    # All properties of key that will be set as methods
    def self.properties
      %i[
        name
        description
        use_message
        missing_message
      ]
    end

    properties.each do |property|
      define_method(property) do
        key_data[property.to_s]
      end
    end

    # @return [String]
    # This method will return either the standard message for using the key correctly
    # If a use_message cannot be found, it will return a fallback message that indicates we need to code something
    def use
      Screen.output(message.yellow)
    end

    private

    def message
      use_message || fallback_message
    end

    def fallback_message
      Logger.error("ERROR: Missing use_message on key. key_id: #{id}")
      'ERROR: Unknown Key - Will use up and continue.'
    end

    def key_data
      key_yml[id] || raise("Key not found with ID: #{id}")
    end
  end
end
