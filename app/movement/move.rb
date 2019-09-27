module MUD
  module Movement
    class Move
      class << self
        include MUD::Helpers::Data
        
        def look_around
          'Not implemented yet'
        end

        def north
          if north_room
            move_to(north_room)
            puts 'You went North'
            'You went North'
          else
            'No go'
          end
        end

        def south
          if south_room
            move_to(south_room)
            puts 'You went South'
            'You went South'
          else
            'No go'
          end
        end

        def east
          if east_room
            move_to(east_room)
            puts 'You went East'
            'You went East'
          else
            'No go'
          end
        end

        def west
          if west_room
            move_to(west_room)
            puts 'You went West'
            'You went West'
          else
            'No go'
          end
        end

        def up
          'Not in active use'
        end

        def down
          'Not in active use'
        end

        def pickup_item
          'Not in active use'
        end

        def drop_item
          'Not in active use'
        end

        def pickup_gold
          'Not in active use'
        end

        def drop_gold
          'Not in active use'
        end

        private

        def move_to(room)
          puts "Moving to #{room}"
          game.player.current_room.leave
          game.player.current_room = room
          game.player.current_room.visit
        end

        def north_room
          connected_rooms['north']
        end

        def south_room
          connected_rooms['south']
        end

        def east_room
          connected_rooms['east']
        end

        def west_room
          connected_rooms['west']
        end
        
        def connected_rooms
          game.connected_rooms
        end
      end
    end
  end
end

