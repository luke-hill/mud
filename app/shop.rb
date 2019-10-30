# frozen_string_literal: true

module MUD
  class Shop < Room
    def buy(item_id)
      Actions::Buy.new(player, item_id).buy
    end

    def enemy
      super
      return if no_enemy?

      MUD::Logger.debug("Enemy found: #{enemy.inspect}")
      raise RuntimeError, "There shouldn't be any enemies in shops!"
    end

    private

    def no_enemy?
      enemy.id == nil || enemy.id == 'no_enemy'
    end
  end
end
