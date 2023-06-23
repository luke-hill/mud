# frozen_string_literal: true

module MUD
  # MUD::Classes are a list of all classes that can be undertaken by the hero
  #
  # All Classes inherit from the Base class
  #
  # Fighter - a Physical Fighter with no magic abilities. Can wield all armor/weapons
  module Classes
  end
end

require_relative 'classes/base'
require_relative 'classes/fighter'
