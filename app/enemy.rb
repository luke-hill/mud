# frozen_string_literal: true

module MUD
  # MUD::Enemy is the way in which all enemies are represented ingame
  #
  # They are created as instances of this Enemy class with a representative id that will then be used to lookup their
  # statistics from the yml db
  #
  # Should an enemy not be found in the regular enemy db it will then look in the boss db
  # Should a boss not be found in the boss db, a RuntimeError will be thrown and the game will crash
  class Enemy
    include Helpers::Data

    attr_writer :gold, :hp
    attr_accessor :id

    # @return [MUD::Enemy]
    # Return an instance of the enemy class with correct id set and type pre-loaded
    def self.of_type(type)
      new.tap do |enemy|
        enemy.id = (type || 'no_enemy')
        enemy.type
      end
    end

    # @return [Array]
    # All properties of the enemy that will be set as methods
    def self.properties
      %i[
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
        phrase1_chance
        phrase1_message
        phrase2_chance
        phrase2_message
      ]
    end

    properties.each do |property|
      define_method(property) do
        enemy_data[property.to_s]
      end
    end

    # @return [Integer]
    # This will generate (and cache), the enemies gold - it will fall between the lower and upper limits
    def gold
      @gold ||= rand(lower_gold_limit..upper_gold_limit)
    end

    # @return [Integer]
    # This will generate (and cache), the enemies hp - it will fall between the lower and upper limits
    def hp
      @hp ||= rand(lower_hp_limit..upper_hp_limit)
    end

    # @return [Boolean]
    # Whether there is an enemy and it is alive
    def alive?
      id != 'no_enemy' && hp.positive?
    end

    # @return [Boolean]
    # Whether there is not an enemy or the enemy is dead
    def dead?
      !alive?
    end

    # @return [0 || Nil]
    # This is a helper that will prevent an enemy from having negative hp overall
    def prevent_negative_hp
      self.hp = 0 if hp.negative?
    end

    # @return [Integer]
    # The overall defense stat of the enemy
    def defense
      Armor.of_type(armor_id).defense
    end

    # @return [Boolean]
    # Whether the enemy has a potion set to drop
    def potion?
      !dropped_potion_id.nil?
    end

    # @return [Boolean]
    # Whether the enemy has a weapon set to drop
    def weapon?
      !dropped_weapon_id.nil?
    end

    # @return [Boolean]
    # Whether the enemy has an armor set to drop
    def armor?
      !dropped_armor_id.nil?
    end

    # @return [String || Nil]
    # The phrase the enemy was due to speak if triggered
    def speak
      phrase.tap do |message|
        Screen.output("#{name.blue}: #{message.green}") if message
      end
    end

    # @return [Symbol]
    # The type of enemy (enemy/boss)
    def type
      @type ||= determine_type
    end

    private

    def enemy_data
      @enemy_data ||=
        case type
        when :enemy; then enemy_yml[id]
        when :boss;  then boss_yml[id]
        else         raise "Enemy/Boss not found with ID: #{id}"
        end
    end

    def determine_type
      return :enemy if enemy?
      return :boss if boss?

      :unknown
    end

    def enemy?
      enemy_yml.key?(id)
    end

    def boss?
      boss_yml.key?(id)
    end

    def phrase
      return phrase1_message if phrase1_chance && rand < phrase1_chance
      return phrase2_message if phrase2_chance && rand < phrase2_chance

      Logger.debug('Neither message triggered. No message output from enemy')
      nil
    end
  end
end
