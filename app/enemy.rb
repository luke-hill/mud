# frozen_string_literal: true

module MUD
  class Enemy
    attr_reader :id

    include Helpers::Data
    extend Forwardable

    def initialize(id)
      @id = id
    end

    def_delegators :enemy,
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
                   :stamina,
                   :dropped_potion_id,
                   :dropped_potion_chance,
                   :dropped_potion_message,
                   :dropped_weapon_id,
                   :dropped_weapon_chance,
                   :dropped_weapon_message,
                   :dropped_armor_id,
                   :dropped_armor_chance,
                   :dropped_armor_message

    def hp
      @hp ||= rand(lower_hp_limit..upper_hp_limit)
    end

    attr_writer :hp

    def gold
      @gold ||= rand(lower_gold_limit..upper_gold_limit)
    end

    attr_writer :gold

    def alive?
      id != 'no_enemy' && hp.positive?
    end

    def dead?
      !alive?
    end

    def prevent_negative_hp
      self.hp = 0 if hp.negative?
    end

    def defense
      Armor.new(armor_id).defense
    end

    private

    def enemy
      @enemy ||= OpenStruct.new(enemy_data)
    end

    def enemy_data
      enemy_yml[id] || boss_yml[id] || raise("Enemy/Boss not found with ID: #{id}")
    end
  end
end
