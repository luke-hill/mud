module AdminPanel
  module Enemies
    class Boss < AdminPanel::Base
      private

      def yml_file_location
        '/home/luke/Code/mud/data/enemies/boss.yml'
      end
    end
  end
end
