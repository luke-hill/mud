require_relative 'autoloader'
require 'singleton'

module MUD
  class Game
    include Singleton

    attr_reader :player
    attr_accessor :rooms_visited

    def initialize
      set_player_attributes
      create_player_object
      set_rooms_visited_to_blank
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

    def set_rooms_visited_to_blank
      @rooms_visited ||= {}
    end
  end
end

m = MUD::Game.instance
m