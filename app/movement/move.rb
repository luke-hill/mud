module MUD
  module Movement
    class Move
      class << self
        include MUD::Helpers::Data
        
        def look_around
          MUD::Screen.output 'Not implemented yet'.red
        end

        def north
          if north_room_id
            move_to(north_room_id)
            MUD::Logger.info('You went North')
            MUD::Screen.output 'You went North'
          else
            MUD::Logger.info('You cannot go that way')
            MUD::Screen.output 'You cannot go north'.red
          end
        end

        def south
          if south_room_id
            move_to(south_room_id)
            MUD::Logger.info('You went South')
            MUD::Screen.output 'You went South'
          else
            MUD::Logger.info('You cannot go that way')
            MUD::Screen.output 'You cannot go south'.red
          end
        end

        def east
          if east_room_id
            move_to(east_room_id)
            MUD::Logger.info('You went East')
            MUD::Screen.output 'You went East'
          else
            MUD::Logger.info('You cannot go that way')
            MUD::Screen.output 'You cannot go east'.red
          end
        end

        def west
          if west_room_id
            move_to(west_room_id)
            MUD::Logger.info('You went West')
            MUD::Screen.output 'You went West'
          else
            MUD::Logger.info('You cannot go that way')
            MUD::Screen.output 'You cannot go west'.red
          end
        end

        def up
          MUD::Screen.output 'Not in active use'.red
        end

        def down
          MUD::Screen.output 'Not in active use'.red
        end

        def pickup_item
          MUD::Screen.output 'Not in active use'.red
        end

        def drop_item
          MUD::Screen.output 'Not in active use'.red
        end

        def pickup_gold
          MUD::Screen.output 'Not in active use'.red
        end

        def drop_gold
          MUD::Screen.output 'Not in active use'.red
        end

        private

        def move_to(room_id)
          MUD::Logger.info("Moving to Room-ID: #{room_id}")

          room =
            if room_already_visited?(room_id)
              fetch_room_from_cache(room_id)
            else
              MUD::Rooms::Room.new(room_id)
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
