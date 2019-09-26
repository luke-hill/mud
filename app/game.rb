require_relative 'autoloader'

module MUD
  class Game
    attr_reader :player

    def initialize
      set_player_attributes
      create_player_object
    end

    private

    def set_player_attributes
      puts 'For now you must be a Fighter, with 25HP.'
    end

    def create_player_object
      @player ||= Fighter::Player.new
    end

    def player_params
      {
        name: player.name,
        max_hp: player.max_hp,
        hp: player.hp,
        level: player.level,
        stamina: player.stamina,
        experience: player.experience,
        gold: player.gold,
        room_id: player.room_id,
      }
    end
  end
end

m = MUD::Game.new
m