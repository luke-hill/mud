class Enemy < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :weapon_id,
                        :armor_id,
                        :lower_hp_limit,
                        :upper_hp_limit,
                        :accuracy,
                        :lower_gold_limit,
                        :upper_gold_limit,
                        :xp,
                        :xp_killshot,
                        :stamina

  def hp
    @hp ||= rand(lower_hp_limit..upper_hp_limit)
  end

  attr_writer :hp

  def gold
    @gold ||= rand(lower_gold_limit..upper_gold_limit)
  end

  attr_writer :gold

  def dead?
    hp.zero?
  end

  def prevent_negative_hp
    self.hp = 0 if hp.negative?
  end
end
