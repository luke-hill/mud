module MUD
  module Helpers
    # Add extra logging so we can see what each reader / writer method is doing
    # and we can store this in the games internal log files
    module AttributeAccessors
      def self.attribute_names
        %i[name max_hp hp level stamina experience gold inventory]
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
          MUD::Screen.output("Your #{name} was updated")
          MUD::Screen.output("#{name}: #{attributes[name]}")
        end
      end
    end
  end
end
