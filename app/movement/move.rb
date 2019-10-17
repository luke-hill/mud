module MUD
  module Movement
    class Move
      class << self
        include MUD::Helpers::Data
        
        def look_around
          MUD::Screen.output(player.current_room.advanced_description.yellow)
        end

        def north
          if north_room_id
            move_to(north_room_id)
            MUD::Screen.output('You went north')
          else
            MUD::Screen.output('You cannot go north'.red)
          end
        end

        def south
          if south_room_id
            move_to(south_room_id)
            MUD::Screen.output('You went south')
          else
            MUD::Screen.output('You cannot go south'.red)
          end
        end

        def east
          if east_room_id
            move_to(east_room_id)
            MUD::Screen.output('You went east')
          else
            MUD::Screen.output('You cannot go east'.red)
          end
        end

        def west
          if west_room_id
            move_to(west_room_id)
            MUD::Screen.output('You went west')
          else
            MUD::Screen.output('You cannot go west'.red)
          end
        end

        def up
          if up_room_id
            move_to(up_room_id)
            MUD::Screen.output('You went up')
          else
            MUD::Screen.output('You cannot go up'.red)
          end
        end

        def down
          if down_room_id
            move_to(down_room_id)
            MUD::Screen.output('You went down')
          else
            MUD::Screen.output('You cannot go down'.red)
          end
        end

        def pickup_item
          MUD::Screen.output('Not in active use'.red)
        end

        def drop_item
          MUD::Screen.output('Not in active use'.red)
        end

        def pickup_gold
          MUD::Screen.output('Not in active use'.red)
        end

        def drop_gold
          MUD::Screen.output('Not in active use'.red)
        end

        private

        def move_to(room_id)
          MUD::Logger.info("Moving to Room-ID: #{room_id}")

          room =
            if room_already_visited?(room_id)
              fetch_room_from_cache(room_id)
            else
              MUD::Room.new(room_id)
            end

          player.current_room.leave
          player.current_room = room
          player.current_room.visit
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

        def up_room_id
          connected_rooms['up']
        end

        def down_room_id
          connected_rooms['down']
        end
        
        def connected_rooms
          player.connected_rooms
        end

        def room_already_visited?(room_id)
          player.rooms_visited.include?(room_id)
        end

        def fetch_room_from_cache(room_id)
          player.rooms_visited[room_id]
        end
      end
    end
  end
end
