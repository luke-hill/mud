module PlayerHelper
  def current_player
    ActivePlayer.last
  end
end
