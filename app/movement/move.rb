module MUD
  module Movement
    class Move
      class << self
        include MUD::Helpers::Data
        
        def look_around
          'Not implemented yet'
        end

        def north
          if north_room_id
            move_to(north_room_id)
            puts 'You went North'
            'You went North'
          else
            'No go'
          end
        end

        def south
          if south_room_id
            move_to(south_room_id)
            puts 'You went South'
            'You went South'
          else
            'No go'
          end
        end

        def east
          if east_room_id
            move_to(east_room_id)
            puts 'You went East'
            'You went East'
          else
            'No go'
          end
        end

        def west
          if west_room_id
            move_to(west_room_id)
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

        def move_to(room_id)
          puts "Moving to Room-ID: #{room_id}"

          if room_already_visited?(room_id)
            room = fetch_room_from_cache(room_id)
          else
            room = MUD::Rooms::Room.new(room_id)
          end

          game.player.current_room.leave
          game.player.current_room = room
          game.player.current_room.visit
        end

        def north_room_id
          connected_rooms['north']
        end

        def south_room_id
          connected_rooms['south']
        end

        def east_room_id
          connected_rooms['east']
        end

        def west_room_id
          connected_rooms['west']
        end
        
        def connected_rooms
          game.connected_rooms
        end

        def room_already_visited?(room_id)
          game.rooms_visited.include?(room_id)
        end

        def fetch_room_from_cache(room_id)
          game.rooms_visited[room_id]
        end
      end
    end
  end
end

