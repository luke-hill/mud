module MUD
  module Helpers
    module ActiveModelFaker
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        include Data

        def find(*options)
          klass = self
          if klass == Room
            directions = directions_yml[options.first]
            description = descriptions_yml.dig(options.first, 'description')
            advanced_description = descriptions_yml.dig(options.first, 'description')
          elsif klass == Enemy
            # find enemy based on his name ref +snake_case+
          end
        end
      end
    end
  end
end
