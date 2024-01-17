# frozen_string_literal: true

module SpecSupport
  module Player
    def reset_inventory
      MUD::Game.player.inventory = []
      MUD::Game.player.max_inventory_size = 10
    end
  end
end
