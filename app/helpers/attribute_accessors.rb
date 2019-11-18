# frozen_string_literal: true

module MUD
  module Helpers
    # These Attribute Accessors are slightly different to standard ones.
    # We provide extra logging so we can see what each reader / writer method is doing
    # and we can store this in the games internal log files
    module AttributeAccessors
      class << self
        # @return [Array => Symbol]
        # The individual statistic names that comprise a characters class
        def attribute_names
          name_attributes +
            experience_attributes +
            hp_mp_attributes +
            player_attributes +
            item_attributes
        end

        def name_attributes
          %i[
            name
          ]
        end

        def experience_attributes
          %i[
            level
            experience
          ]
        end

        def hp_mp_attributes
          %i[
            max_hp
            hp
            max_mp
            mp
          ]
        end

        def player_attributes
          %i[
            stamina
            strength
            agility
            resilience
            conjuring
          ]
        end

        def item_attributes
          %i[
            gold
            inventory
            max_inventory_size
          ]
        end
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
