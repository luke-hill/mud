module AdminPanel
  module Enemies
    class Enemy < AdminPanel::Base
      private

      def yml_file_location
        '/home/luke/Code/mud/data/enemies/enemy.yml'
      end
    end
  end
end
