module MUD
  module Classes
    class Fighter
      attr_reader :attributes
      private :attributes

      attr_accessor :current_room

      extend Forwardable

      def initialize
        @attributes = starting_attributes
        @current_room = MUD::Rooms::Room.new(starting_room)
      end

      def starting_attributes
        {
          name: 'Test Player',
          max_hp: 25,
          hp: max_hp,
          stamina: 1,
          level: 1,
          experience: 0,
          gold: 200,
          inventory: []
        }
      end

      accessor_methods.each do |name|
        define_method(name) do
          attributes[name]
        end
      end

      private

      def accessor_methods
        reader_methods + writer_methods
      end

      def reader_methods
        %i[name max_hp hp level stamina experience gold inventory]
      end

      def writer_methods
        reader_methods.map { |s| "#{s}=".to_sym }
      end

      def starting_room
        1
      end
    end
  end
end
