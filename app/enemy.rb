# frozen_string_literal: true

module MUD
  class Enemy
    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @enemy = OpenStruct.new(enemy(id))
    end

    def_delegators :@enemy,
                   :name,
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
      @enemy.nil? || hp.zero?
    end

    def prevent_negative_hp
      self.hp = 0 if hp.negative?
    end

    def defense
      Armor.new(armor_id).defense
    end

    private

    def enemy(id)
      enemy_yml[id] || boss_yml[id] || raise(RuntimeError, "Enemy/Boss not found with ID: #{id}")
    end
  end
end
