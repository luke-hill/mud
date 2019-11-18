# frozen_string_literal: true

module MUD
  module Helpers
    # These Attribute Accessors are slightly different to standard ones.
    # We provide extra logging so we can see what each reader / writer method is doing
    # and we can store this in the games internal log files
    module AttributeAccessors
      # @return [Array => Symbol]
      # The individual statistic names that comprise a characters class
      def self.attribute_names
        %i[
          name
          max_hp
          hp
          level
          stamina
          experience
          gold
          inventory
          max_inventory_size
          max_mp
          mp
          strength
          agility
          resilience
          conjuring
        ]
      end

      attribute_names.each do |name|
        define_method(name) do
          MUD::Logger.debug("Call made to read attribute: #{name}")
          attributes[name]
        end
      end

      attribute_names.each do |name|
        define_method("#{name}=") do |value|
          MUD::Logger.debug("Call made to set attributes: #{attributes}")
          attributes[name] = value
          MUD::Logger.debug("Your #{name} was updated")
          MUD::Logger.info("New Value --> #{name}: #{attributes[name]}")
        end
      end
    end
  end
end
