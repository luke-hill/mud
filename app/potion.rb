# frozen_string_literal: true

module MUD
  # MUD::Potion is the way in which all potions are represented ingame
  #
  # This acts a bit like ActiveRecord, and will load the item into Memory for usage
  # It uses the ID of the item (Which is a snake_cased string), and then create a Struct
  # which can access all of the properties through the delegated struct
  #
  # Each potion will be classified as one of 3 types
  #   :healing -> Restore HP to the hero (Up to their maximum HP)
  #   :mana -> Restore MP to the hero (Up to their maximum MP)
  #   :hp_bonus -> Increase their maximum HP above their current maximum (NB: This won't restore any HP)
  #
  # Should the potion fail to be classified, a RuntimeError will be thrown and the game will crash
  class Potion
    include Helpers::Data

    attr_writer :type
    attr_accessor :id

    # @return [MUD::Potion]
    # Return an instance of potion class with correct id set
    def self.of_type(type)
      new.tap do |potion|
        potion.id = type
      end
    end

    # @return [Array]
    # All properties of potion that will be set as methods
    def self.properties
      %i[
        name
        use_message
        description
        value
      ]
    end

    properties.each do |property|
      define_method(property) do
        potion_data[property.to_s]
      end
    end

    # @return [String]
    # Use the potion, ensuring that both hp/mp don't overflow
    def use
      effect
      player.prevent_overflow_hp
      player.prevent_overflow_mp
      Screen.output(dynamic_used_message)
    end

    # @return [Symbol]
    # The type of potion (healing/mana/hp_bonus)
    def type
      @type ||= determine_type
    end

    # @return [String]
    # This method will return either the standard message for using the potion correctly
    # If a use_message cannot be found, it will return a fallback message that indicates we need to code something
    def message
      use_message || fallback_message
    end

    private

    def fallback_message
      Logger.error("ERROR: Missing use_message on potion. potion_id: #{id}")
      'ERROR: Unknown Potion - Will use up and continue.'
    end

    def potion_data
      assign_potion_data
    end

    def effect
      case type
      when :healing;  then player.hp += value
      when :mana;     then player.mp += value
      when :hp_bonus; then player.max_hp += value
      else            raise 'Unreachable code. Potion Type should already have been defined!'
      end
    end

    def dynamic_used_message
      case type
      when :healing;  then "#{message} #{value}hp. #{full_hp_restored_message}".yellow
      when :mana;     then "#{message} #{value}mp. #{full_hp_restored_message}".blue
      when :hp_bonus; then "#{message} #{value}hp.".blink
      else            raise 'Unreachable code. Potion Type should already have been defined!'
      end
    end

    def full_hp_restored_message
      'You feel yourself regain full strength.' if player.hp == player.max_hp
    end

    def full_mp_restored_message
      'You feel yourself regain full magic power.' if player.mp == player.max_mp
    end

    def determine_type
      return self.type = :healing if healing_potion?
      return self.type = :mana if mana_potion?
      return self.type = :hp_bonus if hp_bonus_potion?

      self.type = :unknown
    end

    def healing_potion?
      !healing_potion_yml[id].nil?
    end

    def mana_potion?
      !mana_potion_yml[id].nil?
    end

    def hp_bonus_potion?
      !hp_bonus_potion_yml[id].nil?
    end

    def assign_potion_data
      case type
      when :healing;  then healing_potion_yml[id]
      when :mana;     then mana_potion_yml[id]
      when :hp_bonus; then hp_bonus_potion_yml[id]
      else            raise "Potion not found with ID: #{id}"
      end
    end
  end
end
