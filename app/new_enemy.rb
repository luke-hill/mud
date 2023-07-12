# frozen_string_literal: true

module MUD
  # MUD::NewEnemy is the NEW way in which all enemies are represented ingame
  #
  # They are created as bespoke individal classes with a hard-coded id
  #
  # At creation time we have a direct reference to their statistics from the yml database
  #
  # Should an enemy not be found in the regular enemy db it will then look in the boss db
  #
  # Should a boss not be found in the boss db, a RuntimeError will be thrown and the game will crash
  class NewEnemy
    include Helpers::Data
    
    def self.properties
      %i[
        enemy
        name
        description
        weapon_id
        armor_id
        lower_hp_limit
        upper_hp_limit
        accuracy
        lower_gold_limit
        upper_gold_limit
        xp
        xp_killshot
        stamina
        dropped_potion_id
        dropped_potion_chance
        dropped_potion_message
        dropped_weapon_id
        dropped_weapon_chance
        dropped_weapon_message
        dropped_armor_id
        dropped_armor_chance
        dropped_armor_message
      ]
    end

    properties.each do |property|
      define_method(property) do
        enemy_data[property.to_s]
      end
    end

    def id
      'unknown'
    end

    # @return Integer
    # This will generate (and cache), the enemies hp
    #
    # The hp will fall between the lower and upper limits
    def hp
      @hp ||= rand(lower_hp_limit..upper_hp_limit)
    end

    attr_writer :hp, :gold

    # @return Integer
    # This will generate (and cache), the enemies gold
    #
    # The hp will fall between the lower and upper limits
    def gold
      @gold ||= rand(lower_gold_limit..upper_gold_limit)
    end

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
      !dropped_potion_id.nil?
    end

    def weapon?
      !dropped_weapon_id.nil?
    end

    def armor?
      !dropped_armor_id.nil?
    end

    private

    def enemy_data
      @enemy_data ||= enemy_yml[id] || boss_yml[id] || raise("Enemy/Boss not found with ID: #{id}")
    end
  end
end

MUD::Enemy::Goblin = Class.new(MUD::NewEnemy) do
  def id = 'goblin'
end
