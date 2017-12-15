class Enemy < ApplicationRecord
  def dead?
    hp <= 0
  end
end
