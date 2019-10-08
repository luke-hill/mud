module MUD
  module Classes
    class Fighter
      attr_reader :attributes
      private :attributes

      attr_accessor :current_room

      def self.accessor_methods
        reader_methods + writer_methods
      end

      def self.reader_methods
        %i[name max_hp hp level stamina experience gold inventory]
      end

      def self.writer_methods
        reader_methods.map { |s| "#{s}=".to_sym }
      end

      def initialize
        @attributes = starting_attributes
        @current_room = MUD::Rooms::Room.new(starting_room)
      end

      def starting_attributes
        {
          name: 'Test Player',
          max_hp: 25,
          hp: 25,
          stamina: 1,
          level: 1,
          experience: 0,
          gold: 200,
          inventory: []
        }
      end

      # Add extra logging so we can see what each reader / writer method is doing
      # and we can store this in the games internal log files
      accessor_methods.each do |name|
        define_method(name) do
          proc do
            MUD::Logger.debug("Call made to view attributes: #{attributes}")
            MUD::Screen.output("#{name}: #{attributes[name]}")
          end.call
        end
      end

      private

      def starting_room
        1
      end
    end
  end
end
