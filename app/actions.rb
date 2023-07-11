# frozen_string_literal: true

module MUD
  # MUD::Actions are a list of all actions that can be used by the hero
  #
  # Typically most actions class have a single public method which is similarly named to the class
  module Actions
  end
end

require_relative 'actions/buy'
require_relative 'actions/command'
require_relative 'actions/equip'
require_relative 'actions/move'
require_relative 'actions/pick_up'
require_relative 'actions/use'
