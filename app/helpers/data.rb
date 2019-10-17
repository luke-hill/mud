module MUD
  module Helpers
    module Data
      def descriptions_yml
        load_yml('/home/luke/Code/mud/data/rooms/description.yml')
      end

      def directions_yml
        load_yml('/home/luke/Code/mud/data/rooms/direction.yml')
      end

      def enemy_yml
        load_yml('/home/luke/Code/mud/data/enemies/enemy.yml')
      end

      def boss_yml
        load_yml('/home/luke/Code/mud/data/enemies/boss.yml')
      end

      private

      def load_yml(filename)
        YAML.load_file(filename)
      end

      def player
        MUD::Game.player
      end
    end
  end
end
