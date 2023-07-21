# frozen_string_literal: true

module MUD
  # MUD::Combat is the way in which all combat is undertaken in the game
  #
  # Attack deals with how they physically attack with their weapon (API private)
  # Defend deals with how they guard vs enemies attacks with their weapon (API private)
  # Fight is the "public" api where the player and enemy will attack/defend vs each other
  # ItemDrops is the class that deals with any items being left over after killing an enemy (Including gold)
  # XP is the class that yields experience points to the player
  module Combat
  end
end

require_relative 'combat/attack'
require_relative 'combat/defend'
require_relative 'combat/fight'
require_relative 'combat/item_drops'
require_relative 'combat/xp'
