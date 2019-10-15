module MUD
  module Helpers
    module Data
      def descriptions_yml
        YAML.load_file('/home/luke/Code/mud/data/rooms/descriptions.yml')
      end

      def directions_yml
        YAML.load_file('/home/luke/Code/mud/data/rooms/directions.yml')
      end

      def enemy_yml
        YAML.load_file('/home/luke/Code/mud/data/enemies/enemy.yml')
      end

      def boss_yml
        YAML.load_file('/home/luke/Code/mud/data/enemies/boss.yml')
      end

      private

      def player
        MUD::Game.player
      end
    end
  end
end
