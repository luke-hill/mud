module MUD
  module Helpers
    module Data
      def descriptions_yml
        YAML.load_file('/home/luke/Code/mud/data/rooms/descriptions.yml')
      end

      def directions_yml
        YAML.load_file('/home/luke/Code/mud/data/rooms/directions.yml')
      end

      private

      def game
        MUD::Game.instance
      end
    end
  end
end
