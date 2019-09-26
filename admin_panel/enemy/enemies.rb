require 'yaml'

module AdminPanel
  module Enemy
    class Enemies
      private

      def enemy
        @enemy ||= yml_file[id] || {}
      end

      def update
        puts "Data to be seeded: #{options}"
        puts "Existing Data: #{enemy}"

        options.each do |key, value|
          enemy[key.to_s] = value
        end

        yml_file[id] = enemy
        puts "New UPDATED Data: #{enemy}"
      end

      def yml_file_location
        '/home/luke/Code/mud/data/enemies/enemy.yml'
      end
    end
  end
end
