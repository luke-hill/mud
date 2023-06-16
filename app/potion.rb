# frozen_string_literal: true

module MUD
  class Potion
    include Helpers::Data
    extend Forwardable

    attr_writer :type
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def_delegators :potion,
                   :name,
                   :description,
                   :value

    def use
      effect
      player.prevent_overflow_hp
      player.prevent_overflow_mp
      MUD::Screen.output(dynamic_used_message)
    end

    def type
      @type ||= determine_type
    end

    def use_message
      potion.use_message || fallback_message
    end

    private

    def fallback_message
      Logger.error("ERROR: Missing use_message on potion. potion_id: #{id}")
      'ERROR: Unknown Potion - Will use up and continue.'
    end

    def potion
      @potion ||= OpenStruct.new(potion_data)
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
      when :healing;  then "#{use_message} #{value}hp. #{full_hp_restored_message}".yellow
      when :mana;     then "#{use_message} #{value}mp. #{full_hp_restored_message}".blue
      when :hp_bonus; then "#{use_message} #{value}hp.".blink
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
