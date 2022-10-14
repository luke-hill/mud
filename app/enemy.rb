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

    # @return Integer
    # This will generate (and cache), the enemies hp
    #
    # The hp will fall between the lower and upper limits
    def hp
      @hp ||= rand(lower_hp_limit..upper_hp_limit)
    end

    attr_writer :hp

    # @return Integer
    # This will generate (and cache), the enemies gold
    #
    # The hp will fall between the lower and upper limits
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

    # @return [0 || Nil]
    # This is a helper that will prevent an enemy from having negative hp overall
    def prevent_negative_hp
      self.hp = 0 if hp.negative?
    end

    # @return Integer
    # The overall defense stat of the enemy
    def defense
      Armor.new(armor_id).defense
    end

    def potion?
      enemy_data.key?(:dropped_potion_id)
    end

    def weapon?
      enemy_data.key?(:dropped_weapon_id)
    end

    def armor?
      enemy_data.key?(:dropped_armor_id)
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
