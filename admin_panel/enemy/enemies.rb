require 'yaml'

module AdminPanel
  module Enemy
    class Enemies
      private

      def enemy
        @enemy ||= enemies_yml[id] || {}
      end

      def update
        puts "Data to be seeded: #{options}"
        puts "Existing Enemy Data: #{enemy}"

        options.each do |key, value|
          enemy[key.to_s] = value
        end

        enemies_yml[id] = enemy
        puts "New UPDATED Enemy Data: #{enemy}"
      end

      def save
        File.write(
          '/home/luke/Code/mud/data/enemies/enemy.yml',
          enemies_yml.to_yaml
        )
      end

      def enemies_yml
        @enemies_yml ||= YAML.load_file('/home/luke/Code/mud/data/enemies/enemy.yml')
      end
    end
  end
end
