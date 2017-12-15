class GameController < ApplicationController
  before_action :find_player

  def index
    render :index
  end

  private

  def current_room
    @current_room ||= @player.room
  end

  def find_player
    @player = ACTIVE_GAME.player
  end
end
